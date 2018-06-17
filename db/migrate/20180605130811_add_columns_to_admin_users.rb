class AddColumnsToAdminUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :admin_users, :name, :string
    add_column :admin_users, :role, :string
    add_column :admin_users, :social_no, :integer
  end
end
