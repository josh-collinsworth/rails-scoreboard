class AddOptionsToGame < ActiveRecord::Migration[6.0]
  def change
    change_column_default :games, :options, :json, default: { increment: 1, include_increment_by_one: false, call_players: true, prepend: "", append: "", add_reset: false, add_double: false, add_halve: false }
  end
end
