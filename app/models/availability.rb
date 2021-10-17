# frozen_string_literal: true

class Availability < ApplicationRecord
  belongs_to :table

  validates :quantity_available, :date, presence: true
  validates :quantity_available, numericality: { greater_than_or_equal_to: 0 }

  # set availability to maximum table availability for newly created records
  after_initialize :set_quantity_available_to_table_quantity, if: :new_record?

  private

  def set_quantity_available_to_table_quantity
    return if table.nil?

    self.quantity_available ||= table.quantity
  end
end
