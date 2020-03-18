class SorceryCore < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username,  limit: 191 ,          :null => false
      t.string :email, limit: 191,            :null => false
      t.string :password_digest, limit: 191
      t.integer :level
      t.string :salt, limit: 191

      t.timestamps                null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
