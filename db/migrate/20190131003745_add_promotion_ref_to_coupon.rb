class AddPromotionRefToCoupon < ActiveRecord::Migration
  def change
    add_reference :coupons, :promotion, index: true, foreign_key: true
  end
end
