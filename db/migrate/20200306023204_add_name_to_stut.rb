class AddNameToStut < ActiveRecord::Migration[6.0]
  def change
    add_column :stuts, :player_name, :string
    add_column :stuts, :team_name, :string
  end
end
