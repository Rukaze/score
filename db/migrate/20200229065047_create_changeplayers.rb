class CreateChangeplayers < ActiveRecord::Migration[6.0]
  def change
    create_table :changeplayers do |t|
      t.string :inplayer
      t.string :outplayer
      t.integer :clock

      t.timestamps
    end
  end
end
