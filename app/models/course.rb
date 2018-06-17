class Course < ApplicationRecord
    validates_uniqueness_of :name
    has_many :students, :through => :coursestudenttracks
    has_many :tracks, :through => :coursestudenttracks

    has_many :admin_users, :through => :coursestafftracks
    has_many :tracks, :through => :coursestafftracks
    has_many :tracks, :through => :coursesTracks
    accepts_nested_attributes_for :tracks
    has_many :assignments

    has_many :assignments, :through => :assignmentstaffstudents
    has_many :students, :through => :assignmentstaffstudents
    has_many :admin_users, :through => :assignmentstaffstudents

end
