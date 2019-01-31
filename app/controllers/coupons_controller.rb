class CouponsController < ApplicationController
  def index
    @promotion = Promotion.find(params[:id])
    @coupons = Coupon.where(promotion: @promotion)
  end

  def burn_form; end

  def burn_coupon
    coupon = Coupon.find_by('code = ?', params[:code])
    if !coupon.nil?
      coupon.burn_coupon(current_user, params[:reason])
      check_burned_coupon(coupon)
    else
      flash[:notice] = 'Você deve informar um código válido'
    end
    redirect_to burn_path
  end

  private

  def check_burned_coupon(coupon)
    flash[:notice] = if coupon.coupon_burning.persisted?
                       'Cupom queimado com sucesso'
                     else
                       'Você deve informar um motivo'
                     end
  end
end
