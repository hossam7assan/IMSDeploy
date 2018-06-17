class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.string :sender_model
      
      t.integer :receiver_id
      t.string :receiver_model

      t.text :message
      t.timestamps
    end
  end
end
