class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, 
                  :password_confirmation, :remember_me

  validates :email, uniqueness: true

  has_many :posts
  extend Hashifiable
  hashify :email, :name, :password
end
