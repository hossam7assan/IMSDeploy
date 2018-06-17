class Cv < ApplicationRecord
    belongs_to :student
    mount_uploader :path, CvUploader
end
