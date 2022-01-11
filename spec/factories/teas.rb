FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety }
    description { Faker::Lorem.sentence }
    temperature { Faker::Number.between(from: 140, to: 212) }
    brew_time { Faker::Number.between(from: 1, to: 5) }
  end
end
