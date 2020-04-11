class CreateParticipantsInGames < ActiveRecord::Migration[6.0]
  def change
    create_table :participants_in_games do |t|
      t.references :games, null: false, foreign_key: true
      t.references :participants, null: false, foreign_key: true

      t.timestamps
    end
  end
end
