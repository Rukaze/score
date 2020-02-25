class ChangeOncourtsToStart5 < ActiveRecord::Migration[6.0]
  def change
    rename_table :oncourts, :start5
  end
end
