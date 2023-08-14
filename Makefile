# Default Goal
.DEFAULT_GOAL := all

# Variables
HUGO_FLAGS := --gc --minify

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# General Targets

# Run everything in sequence: clean, update, normalize, and build
.PHONY: all
all: debug clean update-wowchemy normalize-yaml build format lint

# Clean the environment
.PHONY: clean
clean:
	rm -rf public
	hugo mod clean
	hugo mod tidy

# Update wowchemy modules
.PHONY: update-wowchemy
update-wowchemy:
	hugo mod get -u ./...
	hugo mod tidy

# Normalize YAML
.PHONY: normalize-yaml
normalize-yaml:
	hugo convert toYAML --unsafe

# Build the Hugo site
.PHONY: build
build:
	hugo $(HUGO_FLAGS)

# Start the Hugo server
.PHONY: serve
serve:
	hugo serve $(HUGO_FLAGS) --buildFuture

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Specialized Targets for creating content

.PHONY: post
post:
	poetry run python scripts/hugo_new.py post --branch

.PHONY: event
event:
	poetry run python scripts/hugo_new.py event --branch

.PHONY: project
project:
	poetry run python scripts/hugo_new.py project --branch

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Debug and Info

# Display Hugo environment details
.PHONY: debug
debug:
	hugo env

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Python Targets

.PHONY: format
format:
	poetry run black .
	poetry run isort .
	poetry run ruff --fix .

.PHONY: lint
lint:
	poetry run black --check .
	poetry run isort -c .
	poetry run ruff check .
