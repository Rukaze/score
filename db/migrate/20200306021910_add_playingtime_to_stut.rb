class AddPlayingtimeToStut < ActiveRecord::Migration[6.0]
  def change
    add_column :stuts, :playingtime, :integer
  end
end
