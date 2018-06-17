class AddColumnsToStudents < ActiveRecord::Migration[5.2]
  def change
  	add_column :students, :gender, :string
  	add_column :students, :name, :string
    add_column :students, :birth, :datetime
    add_column :students, :avatar, :string
  	add_column :students, :group_id, :integer
  end
end
