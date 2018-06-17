class EditStudentIdAndStaffIdToTable < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :student_id , :integer , :null => true
    change_column :posts, :staff_id , :integer , :null => true
  end
end
