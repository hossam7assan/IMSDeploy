class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.integer :admin_user_id
      t.integer :track_id

      t.timestamps
    end
  end
end
