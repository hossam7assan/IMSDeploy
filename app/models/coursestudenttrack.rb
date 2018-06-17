class Coursestudenttrack < ApplicationRecord
    # self.primary_keys = :course_id, :student_id, :track_id
    # add_index :coursestudenttracks, [:course_id, :student_id, :track_id], unique: true
    belongs_to :course
    belongs_to :track
    belongs_to :student
end
