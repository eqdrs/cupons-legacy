class Promotion < ActiveRecord::Base
  has_many :coupons
  before_save :set_end_at

  validates :title, :description, :discount, :start_at, :duration, :prefix,
            :quantity, presence: true
  validates :discount, :duration, :quantity, numericality: true

  def generate_coupons(quantity = nil)
  end

  def set_end_at
    self.end_at = start_at.end_of_day + duration.days
  end

  def used_coupons?
    used_coupons != []
  end

  def give_coupon
    nil
  end

  def report_not_used_coupons
    coupons.where.not(id: used_coupons.pluck(:coupon_id))
  end
end
