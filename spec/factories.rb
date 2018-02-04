require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:email, 100) { |n| "person#{n}@example.com" }
    # email {(0...9).map { ('a'..'z').to_a[rand(26)] }.join + '@test'}
    # password {(0...9).map { ('a'..'z').to_a[rand(26)] }.join}
    # email 'test@test'
    password "password"
    password_confirmation "password"
  end
end