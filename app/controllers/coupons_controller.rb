class CouponsController < ApplicationController
  def index
    @promotion = Promotion.find(params[:id])
    @coupons = Coupon.where(promotion: @promotion)
  end
end
