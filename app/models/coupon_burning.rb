class CouponBurning < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :user

  validates :reason, presence: true
end
