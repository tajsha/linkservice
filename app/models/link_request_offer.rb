class LinkRequestOffer < ActiveRecord::Base
  belongs_to :link_request
  belongs_to :user
end
