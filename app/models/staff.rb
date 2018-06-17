class Staff < ApplicationRecord

    belongs_to :admin_user
    belongs_to :track
    
end
