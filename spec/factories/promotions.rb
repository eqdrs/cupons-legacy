FactoryGirl.define do
  factory :promotion do
    title { FFaker::Name.name }
    description { FFaker::Lorem.paragraph }
    discount '50'
    start_at Time.zone.now
    prefix 'AAA'
    quantity '10'
    duration '5'
    user

    factory :expired_promotion do
      prefix 'AAA'
      start_at { 5.days.ago }
      duration '3'
    end
  end
end
