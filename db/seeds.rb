Restaurant.create!([
  { name: 'restaurant' },
  { name: 'other_restaurant' }
])

Table.create!([
  { restaurant_id: 1, name: 'table', quantity: 2, min_guests: 1, max_guests: 3, available_from: '10:00', available_to: '12:00' },
  { restaurant_id: 1, name: 'table_with_no_reservations', quantity: 5, min_guests: 1, max_guests: 5, available_from: '10:00', available_to: '12:00' },
  { restaurant_id: 1, name: 'table_with_not_enough_seats', quantity: 2, min_guests: 1, max_guests: 2, available_from: '10:00', available_to: '12:00' },
  { restaurant_id: 1, name: 'table_not_available_at_time', quantity: 2, min_guests: 1, max_guests: 3, available_from: '14:00', available_to: '16:00' },
  { restaurant_id: 1, name: 'fully_booked_table', quantity: 2, min_guests: 1, max_guests: 3, available_from: '10:00', available_to: '12:00' },
  { restaurant_id: 2, name: 'other_restaurant_table', quantity: 2, min_guests: 1, max_guests: 3, available_from: '10:00', available_to: '12:00' }
])

Availability.create!([
  { table_id: 1, date: '2021-10-20', quantity_available: 1 },
  { table_id: 5, date: '2021-10-20', quantity_available: 0 },
])

Reservation.create!([
  { table_id: 1, name: nil, email: 'guest1@ex.com', guests: 1, date: '2021-10-20' },
  { table_id: 5, name: nil, email: 'guest2@ex.com', guests: 2, date: '2021-10-20' },
  { table_id: 5, name: nil, email: 'guest2@ex.com', guests: 3, date: '2021-10-20' }
])
