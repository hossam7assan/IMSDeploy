class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :intake
      t.string :typeoftrack

      t.timestamps
    end
  end
end
