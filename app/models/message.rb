class Message < ApplicationRecord
    belongs_to :student
    belongs_to :admin_user

end
