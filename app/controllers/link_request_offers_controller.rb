class LinkRequestOffersController < ApplicationController
  before_action :set_link_request_offer, only: [:show, :edit, :update, :destroy, :offer_payment]

  # GET /link_request_offers
  # GET /link_request_offers.json
  def index
    @link_request_offers = LinkRequestOffer.all
  end

  # GET /link_request_offers/1
  # GET /link_request_offers/1.json
  def show
  end

  # GET /link_request_offers/new
  def new
    @link_request_offer = LinkRequestOffer.new
  end

  # GET /link_request_offers/1/edit
  def edit
  end

  # POST /link_request_offers
  # POST /link_request_offers.json
  def create
    @link_request_offer = LinkRequestOffer.new(link_request_offer_params)
    @link_request_offer.user_id = current_user.id
    @link_request_offer.status = 'I'
    respond_to do |format|
      if @link_request_offer.save
        format.html { redirect_to link_request_url(@link_request_offer.link_request), notice: 'Link request offer was successfully created.' }
        format.json { render :show, status: :created, location: @link_request_offer }
      else
        format.html { render :new }
        format.json { render json: @link_request_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /link_request_offers/1
  # PATCH/PUT /link_request_offers/1.json
  def update
    respond_to do |format|
      if @link_request_offer.update(link_request_offer_params)
        format.html { redirect_to @link_request_offer, notice: 'Link request offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @link_request_offer }
      else
        format.html { render :edit }
        format.json { render json: @link_request_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /link_request_offers/1
  # DELETE /link_request_offers/1.json
  def destroy
    @link_request_offer.destroy
    respond_to do |format|
      format.html { redirect_to link_request_offers_url, notice: 'Link request offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link_request_offer
      @link_request_offer = LinkRequestOffer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_request_offer_params
      params.require(:link_request_offer).permit(:description, :price, :link_request_id, :status)
    end
end
