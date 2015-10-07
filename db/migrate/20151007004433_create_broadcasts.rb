class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.string :title, null: false
      t.string :short_description

      t.timestamps null: false
    end
  end
end
