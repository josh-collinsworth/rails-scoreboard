class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.string :name
      t.integer :score

      t.timestamps
    end
    add_index :participants, :name
  end
end
