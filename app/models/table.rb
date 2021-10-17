# frozen_string_literal: true

class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :availabilities, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :quantity, :min_guests, :max_guests, :available_from, :available_to, presence: true
end
