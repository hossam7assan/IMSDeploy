class Track < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :intake, presence: true
  validates :typeoftrack, presence: true
    has_many :courses
    #has_many :courses, :through => :coursestudenttracks, dependent: :destroy
    has_many :students
    #has_many :students, :through => :coursestudenttracks, dependent: :destroy

    #has_many :students, :through => :lists, dependent: :destroy
    has_many :timetables
    has_many :admin_users
    #has_many :admin_users, :through => :staffs, dependent: :destroy
    #has_many :courses, :through => :coursesTracks, dependent: :destroy
    
    #has_many :admin_users, :through => :coursestafftracks, dependent: :destroy
    #has_many :courses, :through => :coursestafftracks, dependent: :destroy
end
