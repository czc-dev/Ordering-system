init:
	docker-compose build
	docker-compose run --rm web bundle install
	docker-compose run --rm web bundle exec rails db:reset

b:
	docker-compose build

# update gems
bundle:
	docker-compose run --rm web bundle

pinit:
	# Current is get error `Faker not found`
	docker-compose run --rm web bundle exec rails db:reset RAILS_ENV=production
	docker-compose run --rm web bundle exec rails assets:precompile

dbreset:
	docker-compose run --rm web bundle exec rails db:reset

up:
	docker-compose up

upd:
	docker-compose up -d

upb:
	docker-compose up --build

upbd:
	docker-compose up --build -d

stop:
	docker-compose stop

down:
	docker-compose down

# restart
rs:
	docker-compose stop
	docker-compose up -d

ps:
	docker ps
	docker-compose ps

# remove logs
rml:
	rm -f web/log/*.log

# remove caches
rmc:
	rm -rf web/tmp/cache/*

# generate ERD (require: graphviz)
erd:
	rm -f web/erd.*
	docker-compose run --rm web bundle exec rails erd filetype='dot'
	dot -Tpdf web/erd.dot -o web/erd.pdf

# run tests for local
tests:
	docker-compose run --rm nginx nginx -t
	docker-compose run --rm unbound unbound-checkconf
	docker-compose run --rm web bundle exec rspec

# rails routes
routes:
	docker-compose run --rm web bundle exec rails routes