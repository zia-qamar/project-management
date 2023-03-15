# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "test_#{i}@example.com" }
    first_name { "Test" }
    last_name { "Admin" }
    password { "TestTest" }
  end
end
