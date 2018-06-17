class Group < ApplicationRecord
  validates :name, uniqueness: true
    has_many :students
end
