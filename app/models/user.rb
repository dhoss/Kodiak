class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :email, uniqueness: true

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
end
