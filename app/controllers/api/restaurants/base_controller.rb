# frozen_string_literal: true

module API
  module Restaurants
    class BaseController < ::ApplicationController
      private

      def restaurant
        @restaurant ||= Restaurant.find(params[:restaurant_id])
      end
    end
  end
end
