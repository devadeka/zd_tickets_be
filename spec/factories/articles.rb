FactoryBot.define do
  factory :article do
    external_id { Faker::Number.number(10) }
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
end