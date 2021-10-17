# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :table

  validates :email, :guests, :date, presence: true
  validates :guests, numericality: { less_than_or_equal_to: ->(r) { r.table.max_guests } }
end
