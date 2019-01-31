class Coupon < ActiveRecord::Base
  belongs_to :user
  belongs_to :promotion
  has_one :coupon_burning

  enum status: [:active, :burned, :used]

  def burn_coupon(current_user, reason)
    burned!
    CouponBurning.create(coupon: self, user: current_user,
                         reason: reason)
  end
end
