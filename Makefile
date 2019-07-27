init: build bundle dbsetup dbseed dbmigrate-test dbseed-test yarn

build:
	docker-compose build

bundle:
	docker-compose run --rm web bundle

dbsetup:
	docker-compose run --rm web bundle exec rails db:setup

dbmigrate:
	docker-compose run --rm web bundle exec rails db:migrate

dbmigrate-test:
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rails db:migrate

dbseed:
	docker-compose run --rm web bundle exec rails db:seed

dbseed-test:
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rails db:seed

production: build-prod dbsetup-prod up-prod

build-prod:
	docker-compose -f docker-compose.prod.yml build

dbsetup-prod:
	docker-compose -f docker-compose.prod.yml run --rm -e RAILS_ENV=production \
	web ./scripts/wait-for-it.sh postgres:5432 -- bundle exec rails db:setup

up-prod:
	docker-compose -f docker-compose.prod.yml up -d

yarn:
	docker-compose run --rm web yarn

yarn-build:
	docker-compose run --rm web yarn build

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
rs: down up

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
