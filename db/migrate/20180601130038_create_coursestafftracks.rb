class CreateCoursestafftracks < ActiveRecord::Migration[5.2]
  def change
    create_table :coursestafftracks do |t|
      t.integer :course_id
      t.integer :admin_user_id
      t.integer :track_id
      t.integer :group
      t.text :material
      t.text :material_name
      t.text :material_type
      t.timestamps
    end
  end
end
