class Assignment < ApplicationRecord
    has_many :admin_users, :through => :assignmentstaffstudents
    has_many :students, :through => :assignmentstaffstudents 
    mount_uploader :assignmentfile, AssignmentfileUploader
    has_one :course
    
end
