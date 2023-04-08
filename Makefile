.DEFAULT_GOAL := all

BIB_SOURCES := $(shell find content -iname "*.bib")
NOTEBOOK_SOURCES := $(shell find content -iname "*.ipynb")
MD_NOTEBOOK_OUT := $(NOTEBOOK_SOURCES:ipynb=md)
FEATURED_IMAGES := $(shell find content -iname "featured.*")

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# phony targets

.PHONY: all
all: build-notebooks normalize-yaml build

.PHONY: build
build: hugo-info normalize-yaml
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
serve: hugo-info normalize-yaml build-notebooks
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
	pipenv run python scripts/hugo_new.py post --branch

.PHONY: event
event:
	pipenv run python scripts/hugo_new.py event --branch

.PHONY: project
project:
	pipenv run python scripts/hugo_new.py project --branch

.PHONY: publication
publication:
	pipenv run python scripts/hugo_new.py publication --branch

.PHONY: notebook
notebook:
	pipenv run python scripts/hugo_new.py post --notebook --branch

.PHONY: debug
debug:
	@echo BIB_SOURCES: $(BIB_SOURCES)
	@echo NOTEBOOK_SOURCES: $(NOTEBOOK_SOURCES)
	@echo MD_NOTEBOOK_OUT: $(MD_NOTEBOOK_OUT)

.PHONY: resize-featured-images
resize-featured-images: $(FEATURED_IMAGES)
	for IMAGE in $(FEATURED_IMAGES); do \
		echo $$IMAGE && \
		mogrify -resize 1200x\> $$IMAGE; \
		mogrify -resize \>x630 $$IMAGE; \
	done

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# file targets

%.md: %.ipynb
	pipenv run jupyter nbconvert --to markdown $<
