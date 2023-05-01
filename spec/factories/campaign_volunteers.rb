FactoryBot.define do
  factory :campaign_volunteer do
    association :campaign
    association :volunteer
  end
end