.DEFAULT_GOAL := build
BIB_SOURCES := $(shell find content -iname "*.bib")

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# hugo commands

.PHONY: build
build: hugo-info
	hugo --gc --minify

.PHONY: clean
clean: hugo-info
	rm -rf public
	hugo mod clean
	hugo mod tidy

.PHONY: serve
serve: hugo-info
	hugo serve --gc --minify

.PHONY: serve-future
serve-future: hugo-info
	hugo serve --gc --minify --buildFuture

.PHONY: hugo-info
hugo-info:
	hugo env

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# publications

.PHONY: format-publications
format-publications: $(BIB_SOURCES)
	# need to have "bibtool" installed
	# apt install bibtool
	for BIB in $(BIB_SOURCES); do \
		echo $$BIB && \
		bibtool -s $$BIB -o $$BIB; \
	done

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# theme

.PHONY: update-wowchemy
update-wowchemy:
	hugo mod get -u ./...
	hugo mod tidy

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# content

.PHONY: post
post:
	pipenv run python scripts/hugo_new.py post

.PHONY: event
event:
	pipenv run python scripts/hugo_new.py event

.PHONY: project
project:
	pipenv run python scripts/hugo_new.py project

.PHONY: publication
publication:
	pipenv run python scripts/hugo_new.py publication

.PHONY: notebook
notebook:
	pipenv run python scripts/hugo_new.py post --notebook
