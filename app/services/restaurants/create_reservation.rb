# frozen_string_literal: true

module Restaurants
  class CreateReservation
    def initialize(table:)
      @table = table
    end

    def call(params:)
      reservation = build_and_validate_reservation(params)
      availability = create_or_find_availability(params[:date])

      transaction(availability, reservation)
    end

    private

    attr_reader :table

    def transaction(availability, reservation)
      availability.with_lock do
        availability.decrement(:quantity_available)
        availability.save!

        reservation.save!
      end
    end

    def build_and_validate_reservation(params)
      table.reservations
           .build(params)
           .tap(&:validate!)
    end

    def create_or_find_availability(date)
      table.availabilities
           .create_or_find_by!(date: date)
    end
  end
end
