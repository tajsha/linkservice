class OrdersController < ApplicationController
  def express
    @link_request_offer = LinkRequestOffer.find(params[:link_request_offer_id])
    @amount = (@link_request_offer.price * 100).round
    response = EXPRESS_GATEWAY.setup_purchase(@amount,
                                              ip: request.remote_ip,
                                              return_url: new_order_url(:link_request_offer_id => @link_request_offer.id),
                                              cancel_return_url: link_requests_url,
                                              currency: "USD"
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def index
    if current_user.client?
      offers = LinkRequestOffer.where(:link_request_id => current_user.link_requests.map(&:id))
      @orders = Order.where(:link_request_offer_id => offers.map(&:id)).order(created_at: :desc)
    elsif current_user.publisher?
      @orders = Order.where(:link_request_offer_id => current_user.link_request_offers.map(&:id)).order(created_at: :desc)
    end
  end

  def new
    @order = Order.new(:express_token => params[:token])
    @order.link_request_offer_id = params[:link_request_offer_id]
  end

  def create
    ActiveRecord::Base.transaction do
      @order = Order.new(order_params)
      @order.ip = request.remote_ip
      if @order.save
        if @order.purchase
          offer = @order.link_request_offer
          offer.status = 'S'
          offer.save
          flash[:notice] = "Payment Done Successfully"
          redirect_to order_url(@order)
        else
          render :action => "failure"
        end
      else
        rednder :action => 'new'
      end
    end
  end

  def show
    @order = Order.find(params[:id])
    render :action => "success"
  end

  private

  def order_params
    params.require(:order).permit(:express_token, :link_request_offer_id)
  end
end
