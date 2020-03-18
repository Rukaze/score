class AddUseridToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :user_id, :string
  end
end
