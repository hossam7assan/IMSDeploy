class Student < ActiveRecord::Base
  validates :email, presence: true
  validates :gender, presence: true
  validates :name, presence: true 
  validates :group_id, presence: true

    #belongs_to :track
    has_many :messages
    has_many :notifications
    belongs_to :group
    has_one :cv
    acts_as_commontator
    has_many :posts
    has_many :assignments, :through => :assignmentstaffstudents
    has_many :admin_users, :through => :assignmentstaffstudents
    has_many :lists
    has_many :tracks, :through => :lists
    accepts_nested_attributes_for :tracks
    
    has_many :courses, :through => :coursestudenttracks
    has_many :coursestudenttracks
    has_many :tracks, :through => :coursestudenttracks
    
    enum gender: {male: 0, female: 1, any: 2}

    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

    def after_confirmation
      welcome_email
    end
    
    mount_uploader :avatar, AvatarUploader
end
