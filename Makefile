init:
	docker-compose build
	docker-compose run --rm web bundle install
	docker-compose run --rm web bundle exec rails db:reset

b:
	docker-compose build

# update gems
bundle:
	docker-compose run --rm web bundle

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

# clear log
cl:
	cp /dev/null web/log/*.log
