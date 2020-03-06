class AddOppToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :opp_name, :string
    add_column :games, :opp_score, :integer
  end
end
