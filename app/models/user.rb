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

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    puts "INSIDE FIND_FOR_TWITTER_OAUTH"
    user = User.find_by(provider: auth.provider, uid:auth.uid)
    if user
      puts "FOUND USER"
      return user
    else
      puts "FOUND REGISTERED USER"
      registered_user = User.find_by(email: auth.uid + "@twitter.com")
      if registered_user
        return registered_user
      else
        puts "CREATING USER"
        user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.uid+"@twitter.com",
                           password:Devise.friendly_token[0,20])
      end
    end
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end
