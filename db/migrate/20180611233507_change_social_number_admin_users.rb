class ChangeSocialNumberAdminUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :admin_users, :social_no, :string
  end
end
