# frozen_string_literal: true

module Restaurants
  class ReservationsCreateContract < ::BaseContract
    attribute :table_id
    attribute :name, :string
    attribute :email, :string
    attribute :guests
    attribute :date, :date

    validates :table_id, :name, :email, :date, :guests, presence: true
  end
end
