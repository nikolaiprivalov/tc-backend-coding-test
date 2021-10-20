# frozen_string_literal: true

module Restaurants
  class AvailabilitySerializer < BaseSerializer
    attributes :id, :name, :qty_available, :available_from, :available_to, :min_guests, :max_guests

    def id
      object._table_id
    end

    def available_to
      object.available_to.strftime('%H:%M')
    end

    def available_from
      object.available_from.strftime('%H:%M')
    end
  end
end
