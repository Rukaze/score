class ChangeStart5ToTrashStart5s < ActiveRecord::Migration[6.0]
  def change
    rename_table :start5, :start5s
  end
end
