.DEFAULT_GOAL := help

db_recreate: ## Recreate DB
	docker compose run --rm web bundle exec rails db:drop
	docker compose run --rm web bundle exec rails db:create

run_rubocop: ## Run rubocop on all or selected files
	docker compose run --rm web bundle exec rubocop $(filter-out $@,$(MAKECMDGOALS))

run_tests: ## Run rspec tests using single thread
	docker compose run --rm web bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))

up: ## Launch the application in background
	docker compose up -d

down: ## Stop and delete containers
	docker compose down

console: ## Launch rails console
	docker compose run --rm web bundle exec rails c

bundle: ## Run bundle install
	docker compose run --rm web bundle install

bundle_update: ## Run bundle update
	docker compose run --rm web bundle update $(filter-out $@,$(MAKECMDGOALS))

bundle_audit: ## Run bundle audit
	docker compose run --rm web bundle exec bundler-audit check --update

bash: ## Run bash in app container
	docker-compose run --rm web bash

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'