class Api::V1::CouponsController < Api::V1::ApplicationController
  def show
    coupon = Coupon.find_by('code = ?', params[:code])
    return render json: coupon unless coupon.nil?
    render text: 'Cupom inexistente!', status: 404
  end

  def use_coupon
    coupon = Coupon.find_by('code = ?', params[:code])
    return burning_validation(coupon) unless coupon.nil?
    render text: 'Cupom inexistente!', status: 404
  end

  private

  def burning_validation(coupon)
    if coupon.burned? || coupon.used?
      render text: 'Cupom inválido!', status: 412
    elsif valid_purchase_number?
      coupon.update(app: params[:app],
                    purchase_number: params[:purchase_number], status: :used)
      render json: coupon
    else
      render text: 'Número do pedido inválido!', status: 412
    end
  end

  def valid_purchase_number?
    Coupon.find_by('purchase_number = ?', params[:purchase_number]).nil?
  end
end
