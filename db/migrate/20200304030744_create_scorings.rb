class CreateScorings < ActiveRecord::Migration[6.0]
  def change
    create_table :scorings do |t|
      t.string :kind
      t.string :player_id
      t.string :game_id
      t.string :quarter

      t.timestamps
    end
  end
end
