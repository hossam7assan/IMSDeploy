class Coursestafftrack < ApplicationRecord
    belongs_to :course
    has_one :admin_user
    belongs_to :track
    mount_uploader :material, MaterialUploader
end