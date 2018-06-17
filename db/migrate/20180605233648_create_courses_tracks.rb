class CreateCoursesTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :courses_tracks do |t|
      t.integer :course_id 
      t.integer :track_id
      t.timestamps
    end
  end
end
