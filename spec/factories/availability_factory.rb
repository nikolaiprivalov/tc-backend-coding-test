# frozen_string_literal: true

FactoryBot.define do
  factory :availability do
    quantity_available { Faker::Number.between(from: 0, to: 5) }
    date { Time.zone.today }

    table
  end
end
