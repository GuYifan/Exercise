require 'factory_bot'

FactoryBot.define do

  factory :user do
    email (0...9).map { ('a'..'z').to_a[rand(26)] }.join + '@test'
    password (0...9).map { ('a'..'z').to_a[rand(26)] }.join
  end
end