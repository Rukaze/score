class RenameTeamNameColumnToPlayers < ActiveRecord::Migration[6.0]
  def change
    rename_column :players, :team_name, :team_id
  end
end
