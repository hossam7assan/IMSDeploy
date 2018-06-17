class AddIdColumnToTable < ActiveRecord::Migration[5.2]
  def change
    add_index :coursestudenttracks, :id
  end
end
