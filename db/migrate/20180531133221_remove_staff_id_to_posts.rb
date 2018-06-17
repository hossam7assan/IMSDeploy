class RemoveStaffIdToPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :staff_id
  end
end
