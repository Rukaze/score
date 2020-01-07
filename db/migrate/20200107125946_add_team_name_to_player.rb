class AddTeamNameToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :team_name, :string
  end
end
