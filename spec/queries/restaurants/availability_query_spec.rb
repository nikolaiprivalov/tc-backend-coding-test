# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurants::AvailabilityQuery do
  describe '#call' do
    subject(:query) do
      described_class.new(datetime: datetime, restaurant: restaurant, guests: guests).call
    end

    let(:date) { Time.zone.today }
    let(:datetime) { "#{date}T11:00:00+00:00".to_datetime }
    let(:guests) { 3 }

    let(:restaurant) { create(:restaurant) }

    let!(:table) do
      create(:table, restaurant: restaurant, available_from: '10:00', available_to: '12:00',
                     quantity: 2, min_guests: 1, max_guests: 3)
    end

    let(:table_availability_attributes) do
      table.slice(:name, :available_from, :available_to, :min_guests, :max_guests)
           .merge(_table_id: table.id)
    end

    context 'when table has no availability limitation' do
      let(:table_availability_attributes) { super().merge(qty_available: table.quantity) }

      it 'contains table availability with total table number' do
        expect(query).to contain_exactly(have_attributes(table_availability_attributes))
      end
    end

    context 'when table has availability limitation' do
      let(:availability) { create(:availability, table: table, quantity_available: 1, date: date) }
      let(:table_availability_attributes) { super().merge(qty_available: availability.quantity_available) }

      it 'contains table availability with available table number' do
        expect(query).to contain_exactly(have_attributes(table_availability_attributes))
      end
    end

    context 'when table has not enough seats' do
      let(:guests) { table.max_guests + 1 }

      it 'filters out table availability' do
        expect(query).to be_empty
      end
    end

    context 'when table is not available at time' do
      let(:datetime) { "#{date}T15:00:00+00:00".to_datetime }

      it 'filters out table availability' do
        expect(query).to be_empty
      end
    end

    context 'when table is fully booked' do
      before { create(:availability, table: table, quantity_available: 0, date: date) }

      it 'filters out table availability' do
        expect(query).to be_empty
      end
    end

    context 'when table belongs to another restaurant' do
      let!(:table) do
        create(:table, available_from: '10:00', available_to: '12:00',
                       quantity: 2, min_guests: 1, max_guests: 3)
      end

      it 'filters out table availability' do
        expect(query).to be_empty
      end
    end
  end
end
