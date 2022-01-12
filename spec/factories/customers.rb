FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name.downcase}#{last_name.downcase}@mail.com" }
    address { Faker::Address.full_address }
  end
end
