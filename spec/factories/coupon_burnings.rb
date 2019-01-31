FactoryGirl.define do
  factory :coupon_burning do
    coupon
    user
    reason { 'MyString' }
  end
end
