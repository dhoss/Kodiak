class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates_format_of :email, uniqueness: true, :without => TEMP_EMAIL_REGEX, on: :update

  has_many :posts
  has_many :users_roles
  has_many :roles, through: :users_roles

  # put callbacks *after* associations
  # see: https://github.com/rails/rails/issues/12180
  # and http://api.rubyonrails.org/classes/ActiveRecord/AutosaveAssociation.html
  # pertinent documentation text: 
  # "Association with autosave option defines several callbacks on your model (before_save, after_create, after_update). 
  # Please note that callbacks are executed in the order they were defined in model. You should avoid modifying the association content, before autosave callbacks are executed. 
  # Placing your callbacks after associations is usually a good practice."
  
  # use after_create because after_commit doesn't seem to create the role properly
  after_create :add_default_role

  extend Hashifiable
  hashify :email, :name, :password

  def role?(role)
    has_role = roles.include?(Role.find_by(name: role))
  end

  def add_role(role)
    roles << Role.where(name: role).first_or_initialize
  end

  def add_default_role
    if !role? "poster"
      add_role("poster")
    end
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end
