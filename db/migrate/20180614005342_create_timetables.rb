class CreateTimetables < ActiveRecord::Migration[5.2]
  def change
    create_table :timetables do |t|
      t.integer :track_id 
      t.string :timetable_link
      t.timestamps
    end
  end
end
