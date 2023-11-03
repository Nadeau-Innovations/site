# Default Goal
.DEFAULT_GOAL := all

# Variables
HUGO_FLAGS := --gc --minify
BASE_URL := http://localhost:1313
LANDING_PAGES := $(patsubst content/landing/%.md,%,$(wildcard content/landing/*.md))

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
	poetry run python scripts/hugo_new.py post

.PHONY: event
event:
	poetry run python scripts/hugo_new.py event

.PHONY: project
project:
	poetry run python scripts/hugo_new.py project

.PHONY: press-release
press-release:
	poetry run python scripts/hugo_new.py press-release --is_post_archetype

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Debug and Info

# Display Hugo environment details
.PHONY: debug
debug:
	hugo env
	go version

.PHONY: clipboard-content-primary
clipboard-content-primary:
	cat \
		content/_index.md \
		content/about.md \
		content/services.md \
		| xclip -selection clipboard

.PHONY: clipboard-content-landing
clipboard-content-landing:
	cat \
		content/landing/*.md \
		| xclip -selection clipboard

.PHONY: open-landing-pages
open-landing-pages:
	@for page in $(LANDING_PAGES); do \
		open "$(BASE_URL)/landing/$$page/"; \
	done

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
