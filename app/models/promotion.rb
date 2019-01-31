class Promotion < ActiveRecord::Base
  has_many :coupons
  belongs_to :user, required: true
  before_save :set_end_at

  validates :title, :description, :discount, :duration, :prefix,
            :quantity, presence: true
  validates :discount, :duration, :quantity, numericality: { greater_than: 0 }
  validates :start_at,
            presence: { message: I18n.translate('errors.messages.valid_date') }
  validates :prefix, length: { minimum: 3 }

  has_one :promotion_approval

  def generate_coupons(current_user)
    (1..quantity).each do |i|
      code = "#{prefix}#{i.to_s.rjust(4, '0')}"
      Coupon.create(code: code, promotion: self, user: current_user,
                    status: :active)
    end
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

  def author?(current_user)
    user == current_user
  end
end
