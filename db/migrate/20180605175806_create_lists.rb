class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.integer :student_id 
      t.integer :track_id
      t.timestamps
    end
  end
end
