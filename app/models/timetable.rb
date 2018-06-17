class Timetable < ApplicationRecord
    mount_uploader :timetable_link, TimetableUploader
    belongs_to :track
end
