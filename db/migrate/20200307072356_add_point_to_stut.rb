class AddPointToStut < ActiveRecord::Migration[6.0]
  def change
    add_column :stuts, :point, :integer
  end
end
