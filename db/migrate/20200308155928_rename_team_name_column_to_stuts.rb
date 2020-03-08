class RenameTeamNameColumnToStuts < ActiveRecord::Migration[6.0]
  def change
    rename_column :stuts, :team_name, :team_id
  end
end
