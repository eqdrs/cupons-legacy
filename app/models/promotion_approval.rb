class PromotionApproval < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :promotion, required: true
end
