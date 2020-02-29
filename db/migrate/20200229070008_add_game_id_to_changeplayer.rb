class AddGameIdToChangeplayer < ActiveRecord::Migration[6.0]
  def change
    add_column :changeplayers, :game_id, :string
  end
end
