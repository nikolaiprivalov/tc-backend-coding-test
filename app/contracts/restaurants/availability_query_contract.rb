# frozen_string_literal: true

module Restaurants
  class AvailabilityQueryContract < ::BaseContract
    attribute :datetime, :datetime
    attribute :guests, :integer

    validates :datetime, :guests, presence: true
  end
end
