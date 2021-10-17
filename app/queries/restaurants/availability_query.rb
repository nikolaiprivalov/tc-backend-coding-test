# frozen_string_literal: true

module Restaurants
  class AvailabilityQuery
    # This query generates the following SQL:

    # SELECT *
    # FROM   (SELECT *,
    #                Coalesce(availabilities_to_date.quantity_available,
    #                suitable_tables.quantity) AS
    #                qty_available
    #         FROM   (SELECT availabilities.*
    #                 FROM   availabilities
    #                 WHERE  ( DATE = ':datetime' :: DATE )) AS
    #                availabilities_to_date
    #                RIGHT JOIN (SELECT tables.name,
    #                                   tables.quantity,
    #                                   tables.available_from,
    #                                   tables.available_to,
    #                                   tables.min_guests,
    #                                   tables.max_guests,
    #                                   id AS _table_id
    #                            FROM   tables
    #                            WHERE  tables.restaurant_id = :restaurant_id
    #                                   AND ( tables.min_guests <= :guests
    #                                         AND tables.max_guests >= :guests )
    #                                   AND ( tables.available_from :: TIME <=
    #                                         ':datetime'
    #                                       )
    #                                   AND ( tables.available_to :: TIME >
    #                                         ':datetime' ))
    #                        AS suitable_tables
    #                        ON availabilities_to_date.table_id =
    #                           suitable_tables._table_id) AS
    #        table_availabilities_join
    # WHERE  ( table_availabilities_join.qty_available > 0 )

    def initialize(restaurant:, datetime:, guests:)
      @restaurant = restaurant
      @datetime = datetime
      @guests = guests
    end

    def call
      availability_scope
    end

    private

    attr_reader :restaurant, :datetime, :guests

    def availability_scope
      Availability.select('*')
                  .from("(#{table_availabilities_join.to_sql}) AS table_availabilities_join")
                  .where('table_availabilities_join.qty_available > 0')
    end

    def table_availabilities_join
      Availability.select('*, COALESCE(availabilities_to_date.quantity_available, suitable_tables.quantity) '\
                          'AS qty_available')
                  .from("( #{availabilities_to_date.to_sql} ) AS availabilities_to_date")
                  .joins("RIGHT JOIN ( #{suitable_tables.to_sql} ) AS suitable_tables "\
                         'ON availabilities_to_date.table_id = suitable_tables._table_id')
    end

    def availabilities_to_date
      Availability.where('date = :datetime::date', datetime: datetime)
    end

    def suitable_tables
      Table.select(table_fields_to_select).select('id AS _table_id')
           .where(restaurant: restaurant)
           .where('tables.min_guests <= :guests AND tables.max_guests >= :guests', guests: guests)
           .where('tables.available_from <= :datetime', datetime: datetime)
           .where('tables.available_to > :datetime', datetime: datetime)
    end

    def table_fields_to_select
      %i[name quantity available_from available_to min_guests max_guests]
    end
  end
end
