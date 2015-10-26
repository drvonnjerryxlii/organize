class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.text :title, limit: 50, null: false
      t.text :description, limit: 500, null: false
      t.boolean :active, default: true, null: false

      t.timestamps null: false
    end
  end
end
