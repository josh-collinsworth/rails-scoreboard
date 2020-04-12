class AddOptionsToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :options, :json, default: { increment: 1, call_players: true, prepend: "", append: "", add_reset: false, add_double: false, add_halve: false }
  end
end
