.ONESHELL:
.DEFAULT_GOAL := help

COMMAND ?= none ### specify the command to pass to sub-makefiles (build|test)
GIT_HASH ?= githash

help:
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<command> <option>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@printf "\033[1mVariables\033[0m\n"
	@grep -E '^[a-zA-Z0-9_-]+.*?### .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?### "}; {printf "  \033[36m%-21s\033[0m %s\n", $$1, $$2}'
	@# Use ##@ <section> to define a section
	@# Use ## <comment> aside of the target to get it shown in the helper
	@# Use ### <comment> to comment a variable

all: alpine

##@ Alpine
alpine: ## Build Alpine images
	@cd docker

	@make ${COMMAND} GIT_HASH=${GIT_HASH} ALPINE_VERSION=3.15.0 TAG=3.15 LATEST=true