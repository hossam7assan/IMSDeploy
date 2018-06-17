class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  validates :name, presence: true
  validates :social_no, uniqueness: true, presence: true
  validates :role, presence: true

  has_many :events
  has_many :assignments, :through => :assignmentstaffstudents
  has_many :students, :through => :assignmentstaffstudents

  has_many :tracks, :through => :coursestafftracks
  has_many :courses, :through => :coursestafftracks
  # if (current_admin_user.role=="Manager"):
  enum role: {Manager: "Manager", Supervisor: "Supervisor", Instructor: "Instructor"}
  # else
  # enum role: {Instructor: "Instructor"}
  # end 


  has_many :staffs
  has_many :tracks, :through => :staffs
  accepts_nested_attributes_for :tracks

  has_many :messages
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
