FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@test.com" }
    password { "testpass" }
    salt { "asdasdastr4325234324sdfds" }
    crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", "asdasdastr4325234324sdfds") }
  end
end
