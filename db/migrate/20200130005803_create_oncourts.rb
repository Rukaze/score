class CreateOncourts < ActiveRecord::Migration[6.0]
  def change
    create_table :oncourts do |t|
      t.string :team
      t.string :p1
      t.string :p2
      t.string :p3
      t.string :p4
      t.string :p5
      t.timestamps
    end
  end
end
