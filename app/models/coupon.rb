class Coupon < ActiveRecord::Base
  belongs_to :user
  belongs_to :promotion

  enum status: [:active, :burned, :used]
end
