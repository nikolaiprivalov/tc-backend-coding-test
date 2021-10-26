# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurants::CreateReservation do
  describe '#call' do
    subject { described_class.new(table: table).call(params: reservation_params) }

    let(:date) { Time.zone.today }
    let(:table) { create(:table, quantity: 3, max_guests: 3) }
    let(:reservation_params) do
      attributes_for(:reservation).merge(date: date, guests: table.max_guests)
    end

    context 'when reservation params are invalid' do
      let(:reservation_params) { super().merge(guests: table.max_guests + 1) }

      it 'raises validation error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when table availability is not present for the date' do
      it 'creates availability record for table' do
        expect { subject }.to change { table.availabilities.count }.from(0).to(1)
      end

      it 'creates reservation for table' do
        expect { subject }.to change { table.reservations.count }.by(1)
      end

      it 'decrements table availability quantity available' do
        subject

        availability = table.availabilities.take
        expect(availability.quantity_available).to eq(table.quantity - 1)
      end
    end

    context 'when table availability is present for the date' do
      let!(:availability) do
        create(:availability, table: table, date: date, quantity_available: 2)
      end

      context 'when table is fully booked' do
        before { availability.update(quantity_available: 0) }

        it 'raises validation error' do
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      it 'creates reservation for table' do
        expect { subject }.to change { table.reservations.count }.by(1)
      end

      it 'decrements table availability quantity available' do
        expect do
          subject
          availability.reload
        end.to change(availability, :quantity_available).by(-1)
      end
    end
  end
end
