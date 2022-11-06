FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    email { "john.doe@test.com" }
    password { "secret" }
    password_confirmation { "secret" }
  end
end
