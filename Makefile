VERSION         :=      $(shell cat ./VERSION)
IMAGE_NAME      :=      metcalfc/myexample

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	OS = linux
endif
ifeq ($(UNAME_S),Darwin)
	OS = darwin
endif

all: build

run: ## Just run it
	go run main.go

build: ## Build local static binary
	GOOS=${OS} GOARCH=amd64 go build -ldflags="-w -s"

test: ## Run tests
	go test ./... -v

fmt: ## Format go files
	go fmt ./... -v

image: ## Build local snapshot as an image
	docker buildx build -t ${IMAGE_NAME} .

setup: ## Setup the precommit hook
	@which pre-commit > /dev/null 2>&1 || (echo "pre-commit not installed see README." && false)
	@pre-commit install

# The actual release is done via a GitHub action that
# triggers on a new version tag.
release: ## Release to GitHub
	git diff-index --quiet HEAD -- || (echo "Git has changes not releaseing." && false)
	git tag -a $(VERSION) -m "Release" || true
	git push origin $(VERSION)

clean: ## Clean up build artifacts
	docker images -aq ${IMAGE_NAME} | xargs docker rmi --force || true
	rm -rf myexample || true
	rm -rf dist || true

help: ## Show this help message
	@echo 'usage: make [target] ...'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

.PHONY: run build test fmt image release help
