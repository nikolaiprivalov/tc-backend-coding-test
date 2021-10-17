# frozen_string_literal: true

FactoryBot.define do
  factory :table do
    sequence(:name) { |n| "table_#{n}" }
    quantity { Faker::Number.between(from: 1, to: 5) }
    min_guests { Faker::Number.between(from: 1, to: 2) }
    max_guests { min_guests + Faker::Number.between(from: 1, to: 2) }
    available_from { Time.zone.now - 1.hour }
    available_to { Time.zone.now + 1.hour }

    restaurant
  end
end
