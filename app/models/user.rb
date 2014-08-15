class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, uniqueness: true

  has_many :posts
  has_many :users_roles
  has_many :roles, through: :users_roles 
  
  extend Hashifiable
  hashify :email, :name, :password

  def role?(role)
    return role == roles.find_by(name: role).name
  end

  def add_role(role)
    roles << [Role.find_or_create_by(name: role)]
  end

end
