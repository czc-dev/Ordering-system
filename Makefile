init: .env build bundle dbsetup dbseed dbmigrate-test dbseed-test yarn

.env:
	cp .env.sample .env

.PHONY: wait-for-db
wait-for-db:
	docker-compose run --rm web ./scripts/wait-for-it.sh postgres:5432 -- echo "DB is up"

.PHONY: build
build:
	docker-compose build

.PHONY: clear-bundle-config
clear-bundle-config:
	rm -rf .bundle

.PHONY: bundle
bundle: clear-bundle-config
	docker-compose run --rm web bundle

.PHONY: dbsetup
dbsetup: wait-for-db
	docker-compose run --rm web bundle exec rails db:setup

.PHONY: dbmigrate
dbmigrate: wait-for-db
	docker-compose run --rm web bundle exec rails db:migrate

.PHONY: dbmigrate-test
dbmigrate-test: wait-for-db
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rails db:migrate

.PHONY: dbseed
dbseed: wait-for-db
	docker-compose run --rm web bundle exec rails db:seed

.PHONY: dbseed-test
dbseed-test: wait-for-db
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rails db:seed

.PHONY: production
production: check-env pull-prod dbsetup-prod up-prod

.PHONY: pull-prod
pull-prod:
	docker-compose -f docker-compose.prod.yml pull

.PHONY: dbsetup-prod
dbsetup-prod:
	docker-compose -f docker-compose.prod.yml run --rm web ./scripts/wait-for-it.sh postgres:5432 -- echo "DB is up"
	docker-compose -f docker-compose.prod.yml run --rm web bundle exec rails db:setup

.PHONY: up-prod
up-prod:
	docker-compose -f docker-compose.prod.yml up -d

.PHONY: yarn
yarn:
	docker-compose run --rm web yarn

.PHONY: up
up:
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose stop

.PHONY: down
down:
	docker-compose down

.PHONY: ps
ps:
	docker ps
	docker-compose ps

# remove logs
.PHONY: rml
rml:
	rm -f log/*.log

# remove caches
.PHONY: rmc
rmc:
	rm -rf tmp/cache/*

# generate ERD (require: graphviz)
.PHONY: erd
erd:
	rm -f erd.*
	docker-compose run --rm web bundle exec rails erd

.PHONY: rspec
rspec:
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rspec

.PHONY: modspec
modspec:
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rails spec:models

.PHONY: reqspec
reqspec:
	docker-compose run --rm -e RAILS_ENV=test web bundle exec rails spec:requests

# rails routes
.PHONY: routes
routes:
	docker-compose run --rm web bundle exec rails routes

# rails stats
.PHONY: stats
stats:
	docker-compose run --rm web bundle exec rails stats

# rails about
.PHONY: about
about:
	docker-compose run --rm web bundle exec rails about

# rails console --sandbox
.PHONY: console
console:
	docker-compose run --rm web bundle exec rails c --sandbox

.PHONY: credentials-edit
credentials-edit:
	docker-compose run --rm -e EDITOR=vi web bundle exec rails credentials:edit

# alias of `bundle exec`
export cmd
.PHONY: be
be:
	docker-compose run --rm web bundle exec $(cmd)
