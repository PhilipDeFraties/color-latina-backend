FactoryBot.define do
  factory :volunteer do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
  end
end