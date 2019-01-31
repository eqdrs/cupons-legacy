FactoryGirl.define do
  factory :coupon do
    code { 'TESTE0001' }
    status :active
    user
  end
end
