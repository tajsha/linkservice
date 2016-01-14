class CreateLinkRequests < ActiveRecord::Migration
  def change
    create_table :link_requests do |t|
      t.string :title
      t.text :description
      t.integer :user_id, :null => false

      t.timestamps null: false
    end
  end
end
