# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::Restaurants::ReservationsController, type: :controller do
  let(:restaurant) { create(:restaurant) }
  let(:table) { create(:table, restaurant: restaurant) }

  describe 'POST /create' do
    subject { post :create, params: params }

    let(:params) do
      {
        restaurant_id: restaurant.id,
        table_id: table.id
      }.merge(attributes_for(:reservation, guests: 1))
    end

    let(:create_reservation_double) { instance_double(Restaurants::CreateReservation) }

    before do
      allow(Restaurants::ReservationsCreateContract).to receive(:call).and_return(params)
      allow(Restaurants::CreateReservation).to receive(:new).and_return(create_reservation_double)
      allow(create_reservation_double).to receive(:call)
    end

    it 'passes valid params to services' do
      subject

      expect(Restaurants::ReservationsCreateContract).to have_received(:call).with(controller.params)
      expect(Restaurants::CreateReservation).to have_received(:new).with(table: table)
      expect(create_reservation_double).to have_received(:call).with(params: params)
    end

    it { is_expected.to have_http_status(:no_content) }
  end
end
