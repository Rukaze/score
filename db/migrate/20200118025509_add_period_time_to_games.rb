class AddPeriodTimeToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :period_time, :integer
  end
end
