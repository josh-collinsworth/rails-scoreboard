class ModifyOptionsDefault < ActiveRecord::Migration[6.0]
  def up
    change_column :games, :options, :json, default: { increment: 1 }
  end
end
