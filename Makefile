docker_exec = docker-compose exec --user root app

help:
	cat Makefile
install:
	cp ./.env.example ./.env
	docker-compose down -v --remove-orphans
	docker-compose up -d
	${docker_exec} composer install
	${docker_exec} php artisan key:generate
	${docker_exec} php artisan config:clear
	${docker_exec} php artisan cache:clear
up:
	docker-compose up -d
rebuild:
	docker-compose up -d --build
down:
	docker-compose down
sh:
	${docker_exec} sh
route:
	${docker_exec} php artisan route:list --except-vendor
clear:
	${docker_exec} php artisan clear-compiled
	${docker_exec} php artisan cache:clear
	${docker_exec} php artisan config:clear
fresh:
	${docker_exec} php artisan migrate:fresh --seed
seed:
	${docker_exec} php artisan db:seed
lint:
	${docker_exec} vendor/bin/phpcs --standard=phpcs.xml .
lint-fix:
	${docker_exec} vendor/bin/phpcbf --standard=phpcs.xml .
psalm:
	${docker_exec} vendor/bin/psalm --no-cache
test:
	${docker_exec} vendor/bin/pest
doc:
	${docker_exec} php artisan l5-swagger:generate
