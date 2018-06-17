class CreateAssignmentstaffstudents < ActiveRecord::Migration[5.2]
  def change
    create_table :assignmentstaffstudents do |t|
      t.integer :assignment_id 
      t.integer :admin_user_id
      t.integer :student_id
      t.text :codeReview
      t.text :derlivered_assignment
      t.integer :course_id 
      t.text :file
      t.timestamps
    end
  end
end
