all: update install install-dev run initialize-db seed-db

update:
	@pip install --upgrade pip

install: ./services/web/requirements.txt
	@pip install -r ./services/web/requirements.txt

install-dev: requirements-dev.txt
	@pip install -r requirements-dev.txt

build:
	@docker-compose build

run:
	@docker-compose up -d --build

stop:
	@docker-compose down -v

pre-commit:
	@pre-commit install

initial-tag:
	@git tag -a -m "Initial tag." v0.0.1

bump-tag:
	@cz bump --check-consistency --changelog

initialize-db:
	@docker-compose exec web python manage.py create_db

seed-db:
	@docker-compose exec web python manage.py seed_db

test-local:
	@curl localhost:5000/
	@sleep 2
	@curl localhost:5000/users
