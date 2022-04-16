.DEFAULT_GOAL := build

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
format-publications:
	# apt install bibtool
	bibtool -s publications.bib -o publications.bib

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
