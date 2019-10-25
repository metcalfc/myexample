# Go GitHub Actions Demo

> Demo app demonstrating how to use Docker Templates and GitHub actions to implement a CI Pipeline for a Go based REST API service.

![](https://github.com/metcalfc/myexample/workflows/Test/badge.svg)

![](https://github.com/metcalfc/myexample/workflows/Release/badge.svg)

## Features

* Simple "hello world" style golang REST api service.
  * Health check
  * Logging
  * Basic tests
  * Using Go Modules
* Docker best practices
  * Multistage builds
  * FROM scratch approach to build smallest most secure container possible
* Popular Golang quality tools like Go Lint and Go vet executing as pre commit hooks.
* GitHub Action - Test run on all commits and PRs.
* GitHub Action - Binary release with [Go Releaser](https://goreleaser.com/) on version tags.
  * Release Notes
  * Tarballs
  * Docker images built and pushed to Docker Hub.
* VS Code Setup
  * Remote container works out of the box for that F5 experience without local toolchains
  * Service launch configuration
  * Extensions pre loaded
