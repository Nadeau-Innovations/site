.DEFAULT_GOAL := all
BIB_SOURCES := $(shell find content -iname "*.bib")
NOTEBOOK_SOURCES := $(shell find content -iname "*.ipynb")
MD_NOTEBOOK_OUT := $(NOTEBOOK_SOURCES:ipynb=md)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# phony targets

.PHONY: all
all: build-notebooks normalize-yaml build

.PHONY: build
build: hugo-info
	hugo --gc --minify

.PHONY: build-notebooks
build-notebooks: $(MD_NOTEBOOK_OUT)

.PHONY: normalize-yaml
normalize-yaml:
	hugo convert toYAML --unsafe

.PHONY: clean
clean: hugo-info
	rm -rf public
	hugo mod clean
	hugo mod tidy

.PHONY: serve
serve: hugo-info build-notebooks
	hugo serve --gc --minify

.PHONY: serve-future
serve-future: hugo-info
	hugo serve --gc --minify --buildFuture

.PHONY: hugo-info
hugo-info:
	hugo env

.PHONY: format-publications
format-publications: $(BIB_SOURCES)
	# need to have "bibtool" installed
	# apt install bibtool
	for BIB in $(BIB_SOURCES); do \
		echo $$BIB && \
		bibtool -s $$BIB -o $$BIB; \
	done

.PHONY: update-wowchemy
update-wowchemy:
	hugo mod get -u ./...
	hugo mod tidy

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

.PHONY: debug
debug:
	@echo BIB_SOURCES: $(BIB_SOURCES)
	@echo NOTEBOOK_SOURCES: $(NOTEBOOK_SOURCES)
	@echo MD_NOTEBOOK_OUT: $(MD_NOTEBOOK_OUT)

.PHONY: post-branch
post-branch:
	pipenv run python scripts/hugo_new.py post --branch

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# file targets

%.md: %.ipynb
	pipenv run jupyter nbconvert --to markdown $<
