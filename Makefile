init: .env bundle pg dbsetup dbseed dbmigrate-test dbseed-test yarn

.env:
	cp .env.sample .env

.PHONY: wait-for-db
wait-for-db:
	./scripts/wait-for-it.sh localhost:5432 -- echo "DB is up"

.PHONY: bundle
bundle:
	bundle config --local vendor/bundle
	bundle install

.PHONY: pg
pg:
	if [ -z "`docker ps | grep pg-ordering-dev`" ] ; then \
	docker run --rm -d \
	--name pg-ordering-dev \
	-p 5432:5432 \
	--env-file .env \
	-v `pwd`/pgdata:/var/lib/postgres/data postgres:11-alpine; fi

.PHONY: dbsetup
dbsetup: wait-for-db
	bundle exec rails db:setup

.PHONY: dbmigrate
dbmigrate: wait-for-db
	bundle exec rails db:migrate

.PHONY: dbmigrate-test
dbmigrate-test: wait-for-db
	RAILS_ENV=test bundle exec rails db:migrate

.PHONY: dbseed
dbseed: wait-for-db
	bundle exec rails db:seed

.PHONY: dbseed-test
dbseed-test: wait-for-db
	RAILS_ENV=test bundle exec rails db:seed

.PHONY: yarn
yarn:
	yarn

.PHONY: up
up: pg
	bundle exec foreman start

.PHONY: down
down:
	docker stop pg-ordering-dev

.PHONY: production
production: .env pull-prod dbsetup-prod up-prod

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
