class CreateStuts < ActiveRecord::Migration[6.0]
  def change
    create_table :stuts do |t|
      t.string :player_id
      t.string :game_id
      t.integer :FGmake
      t.integer :FGmiss
      t.integer :Deepmake
      t.integer :Deepmiss
      t.integer :FTmake
      t.integer :FTmiss
      t.integer :DefReb
      t.integer :OffReb
      t.integer :Assist
      t.integer :Block
      t.integer :steal
      t.integer :TO
      t.integer :PF

      t.timestamps
    end
  end
end
