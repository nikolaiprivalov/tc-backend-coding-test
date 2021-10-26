# frozen_string_literal: true

module API
  module Restaurants
    class ReservationsController < BaseController
      def create
        ::Restaurants::CreateReservation.new(table: table)
                                        .call(params: reservation_params)

        head :no_content
      end

      private

      def reservation_params
        ::Restaurants::ReservationsCreateContract.call(params)
      end

      def table
        @table ||= restaurant.tables.find(params[:table_id])
      end
    end
  end
end
