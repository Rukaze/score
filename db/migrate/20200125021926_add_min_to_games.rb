class AddMinToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :min, :string
  end
end
