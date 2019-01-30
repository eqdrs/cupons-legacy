class PromotionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new promotion_params
    if @promotion.save
      redirect_to @promotion
    else
      render :new
    end
  end

  def show
    @promotion = Promotion.find(params[:id])
  end

  private

  def promotion_params
    params.require(:promotion)
          .permit(:title, :description, :discount, :start_at, :prefix,
                  :quantity, :duration)
  end
end
