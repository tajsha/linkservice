class CreateLinkRequestOffers < ActiveRecord::Migration
  def change
    create_table :link_request_offers do |t|
      t.text :description
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :link_request_id, :null => false
      t.integer :user_id, :null => false
      t.string :status

      t.timestamps null: false
    end
  end
end
