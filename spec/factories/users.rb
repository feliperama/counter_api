FactoryBot.define do
  factory :user do
    email { "user#{rand(1000)}@test.com" }
    password { "12341234" }
  end
end
