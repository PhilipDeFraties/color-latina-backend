FactoryBot.define do
  factory :message do
    text { Faker::Lorem.sentence }
    association :campaign
  end
end