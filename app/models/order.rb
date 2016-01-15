class Order < ActiveRecord::Base
  belongs_to :link_request_offer

  def purchase
    response = EXPRESS_GATEWAY.purchase((link_request_offer.price * 100).round, express_purchase_options)
    response.success?
  end

  def express_token=(token)
    self[:express_token]=token
    if new_record? && !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
    end
  end

  private

  def express_purchase_options
    {
      :ip => ip,
      :token => express_token,
      :payer_id => express_payer_id,
    }
  end
end
