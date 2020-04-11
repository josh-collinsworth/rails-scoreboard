class AddOptionsToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :options, :json, default: "{}"
  end
end
