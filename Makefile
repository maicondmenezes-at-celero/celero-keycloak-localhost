up:
	docker compose up -d

down:
	docker compose down

build:
	docker compose build

restart:
	docker compose restart

logs:
	docker compose logs -f

logs-keycloak:
	docker compose logs -f keycloak

logs-postgres:
	docker compose logs -f postgres

logs-mailhog:
	docker compose logs -f mailhog

clean:
	docker compose down --volumes

reset: down build up logs

hard-reset: clean build up

.PHONY: up down build restart logs clean reset hard-reset