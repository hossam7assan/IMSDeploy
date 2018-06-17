class Event < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :admin_user
end
