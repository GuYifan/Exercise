# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - ```ruby 2.3.0p0```

* Rails version - ```Rails 5.1.3```

* System dependencies 
	- Postgres (v9.x)
	- Chrome
	- RSpec (by running `rails g rspec:install`)

* Configuration

* Database creation
	- Create a superuser postgres/postgres if that does not exist yet by running `CREATE ROLE postgres WITH LOGIN;` in psql client.

* Database initialization
	- `rake db:drop && rake db:create && rake db:migrate && rake db:seed`

* How to run the test suite
	1. Prepare the database with seeded data.
	2. Starts rails server on port 3000 (`rails s`)
	3. Go to root direct of the project and run the following
	- RSpec ones:
		- Model spec: `bundle exec rspec spec/models/order_spec.rb`
		- Feature spec: `DRIVER=chrome bundle exec rspec spec/features/success_spec.rb` and `DRIVER=chrome bundle exec rspec spec/features/failure_spec.rb`
	- ActiveSupport::TestCase and ActionDispatch::SystemTestCase
		- Model test: `rails test test/models/order_test.rb`
		- System test: `rails test test/application_system_test_case.rb`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
