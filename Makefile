.DEFAULT_GOAL := build
BIB_SOURCES := $(shell find content -iname "*.bib")

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# hugo commands

.PHONY: build
build:
	hugo --gc --minify

.PHONY: clean
clean:
	rm -rf public

.PHONY: serve
serve:
	hugo version
	hugo serve --gc --minify

.PHONY: serve-future
serve-future:
	hugo version
	hugo serve --gc --minify --buildFuture

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
	python3 hugo_new.py post

.PHONY: event
event:
	python3 hugo_new.py event

.PHONY: project
project:
	python3 hugo_new.py project
