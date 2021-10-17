# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    guests { Faker::Number.between(from: 1, to: 4) }
    date { Time.zone.today }

    table
  end
end
