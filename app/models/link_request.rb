class LinkRequest < ActiveRecord::Base
  belongs_to :user
  has_many :link_request_offers
end
