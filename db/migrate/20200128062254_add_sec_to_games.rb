class AddSecToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :sec, :string
  end
end
