.PHONY: python-package help
.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([0-9a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

%:
    @:

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

docker-clean-unused: ## docker system prune --all --force --volumes
	docker system prune --all --force --volumes

docker-clean-all:  ## docker container stop $(docker container ls -a -q) && docker system prune -a -f --volumes
	docker container stop $(docker container ls -a -q) && docker system prune -a -f --volumes

build: ## Build the image and tag it dockerpot
	docker build --tag dockerpot .

jupyter: ## Start jupyter notebook server.
	docker run --publish 8888:8888 --volume $$(pwd)/notebooks:/workspace/notebooks --detach dockerpot jupyter

run_minst: ## Run scripts/run_minst.py inside the 'dockerpot' container.
	docker run dockerpot python /workspace/scripts/run_minst.py --volume $$(pwd)/scripts:/workspace/scripts

stop: ## Stop the 'dockerpot' container.
	docker container stop $$(docker ps -q --filter ancestor=dockerpot)
