class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :add_default_role

  validates :email, uniqueness: true

  has_many :posts
  has_many :users_roles
  has_many :roles, through: :users_roles
  extend Hashifiable
  hashify :email, :name, :password

  def role?(role)
    roles.include?(Role.find_by(name:role))
  end

  def add_role(role)
    roles << Role.find_by(name: role)
  end

  def add_default_role
    p "ADDING ROLE"
    pp roles
    if roles.empty? || (role?("poster") == false)
      p "ADDING ROLE EMPTY"
      roles << Role.find_by(name: "poster")
      pp roles
    end
  end
end
