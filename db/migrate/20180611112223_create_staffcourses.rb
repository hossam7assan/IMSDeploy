class CreateStaffcourses < ActiveRecord::Migration[5.2]
  def change
    create_table :staffcourses do |t|
      t.integer :course_id 
      t.integer :admin_user_id
      t.timestamps
    end
  end
end
