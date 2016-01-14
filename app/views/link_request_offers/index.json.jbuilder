json.array!(@link_request_offers) do |link_request_offer|
  json.extract! link_request_offer, :id, :description, :price, :link_request_id, :status
  json.url link_request_offer_url(link_request_offer, format: :json)
end
