class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :password_digest
      t.text :name, limit: 250, null: false
      t.citext :email, null: false
      t.citext :github
      t.string :type, null: false

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
