class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :student_id
      t.integer :staff_id

      t.timestamps
    end
  end
end
