class CreateOauths < ActiveRecord::Migration
  def change
    create_table :oauths do |t|
      t.belongs_to :user, null: false
      t.text :provider, limit: 64, null: false
      t.text :provider_uid, null: false

      t.timestamps null: false
    end
    add_index :oauths, :user_id
  end
end
