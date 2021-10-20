# frozen_string_literal: true

module API
  module Restaurants
    class AvailabilityController < BaseController
      def query
        availability = ::Restaurants::AvailabilityQuery.new(restaurant: restaurant,
                                                            **query_params).call

        render json: availability, each_serializer: ::Restaurants::AvailabilitySerializer
      end

      private

      def query_params
        ::Restaurants::AvailabilityQueryContract.call(params)
      end
    end
  end
end
