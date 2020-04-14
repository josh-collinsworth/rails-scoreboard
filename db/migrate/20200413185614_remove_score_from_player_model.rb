class RemoveScoreFromPlayerModel < ActiveRecord::Migration[6.0]
  def change
    remove_column :participants, :score
    add_column :game_participants, :score, :integer, default: 0, null: false
  end
end
