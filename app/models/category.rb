class Category < ActiveRecord::Base
  extend Hashifiable
  hashify :name, :id

  validates :name, presence: true, uniqueness: true
end
