class Post < ActiveRecord::Base
    # has_and_belongs_to_many :tags       # foreign keys in the join table
    acts_as_commontable dependent: :destroy
    acts_as_votable
    belongs_to :student 
    acts_as_taggable
    accepts_nested_attributes_for :taggings
    
    def know
        puts "yaraaaaaaaaaaaaaaaaaaaaaaaaaaaab"
      end
end