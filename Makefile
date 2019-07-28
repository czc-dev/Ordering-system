init: check-env build bundle dbsetup dbseed dbmigrate-test dbseed-test yarn

check-env:
	if ! [[ -e .env ]]; then ! echo '.env file does not found. GENERATE IT!'; fi

wait-for-db:
	docker-compose run --rm web ./scripts/wait-for-it.sh postgres:5432 -- echo "DB is up"

build:
	docker-compose build

clear-bundle-config:
	rm -rf .bundle

bundle: clear-bundle-config
	docker-compose run --rm web bundle

dbsetup: wait-for-db
	docker-compose run --rm web bundle exec rails db:setup

dbmigrate: wait-for-db
	docker-compose run --rm web bundle exec rails db:migrate

dbmigrate-test: wait-for-db
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rails db:migrate

dbseed: wait-for-db
	docker-compose run --rm web bundle exec rails db:seed

dbseed-test: wait-for-db
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rails db:seed

production: check-env build-prod dbsetup-prod up-prod

build-prod:
	docker-compose -f docker-compose.prod.yml build

dbsetup-prod: wait-for-db
	docker-compose run --rm -e RAILS_ENV=production web bundle exec rails db:setup

up-prod:
	docker-compose -f docker-compose.prod.yml up -d

yarn:
	docker-compose run --rm web yarn

up:
	docker-compose up -d

stop:
	docker-compose stop

down:
	docker-compose down

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
	rm -f erd.*
	docker-compose run --rm web bundle exec rails erd

rspec:
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rspec

modspec:
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rails spec:models

reqspec:
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rails spec:requests

# rails routes
routes:
	docker-compose run --rm web bundle exec rails routes

# rails stats
stats:
	docker-compose run --rm web bundle exec rails stats

# rails about
about:
	docker-compose run --rm web bundle exec rails about

# rails console --sandbox
console:
	docker-compose run --rm web bundle exec rails c --sandbox

credentials-edit:
	docker-compose run --rm -e EDITOR=vi web bundle exec rails credentials:edit
