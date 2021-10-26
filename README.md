# TC_BACKEND_CODING_TEST

This is an overview!
Please see the commit messages for more of a thought process.

## Quick Start

```sh
# first start
docker-compose run --rm runner bundle
docker-compose run --rm runner rails db:prepare
RAILS_ENV=test docker-compose run --rm runner rails db:create db:schema:load

# server
docker-compose up rails

# tests
RAILS_ENV=test docker-compose run --rm runner rspec 
```

## Try these requests first to see what's what

```
# Availability
curl "localhost:3000/api/availability/1?datetime=2021-10-20T10:00:00+00:00&guests=3"

# Reservation (increment table_id for different errors)
curl -d '{"table_id":"1", "date":"2021-10-20", "name":"jonh doe", "email":"jd@ex.com", "guests":"2"}' -H "Content-Type: application/json" -X POST http://localhost:3000/api/reservations/1
```

## Unfinished:

* Controller specs are missing for the erroneous requests
* Errors are default, date type casting error appear as can't be blank
* Wanted to utilize handlers to achieve properly thin controllers
* Specs are a bit untidy. Limited mocking + stubbing.
I also use very little mocking when testing queries and or record creation services.
