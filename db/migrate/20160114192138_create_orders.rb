class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :ip
      t.string :express_token
      t.string :express_payer_id
      t.string :link_request_offer_id
      t.timestamps null: false
    end
  end
end
