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

.PHONY: publications
publications: format-publications
	# https://pypi.org/project/academic/
	academic import --bibtex publications.bib --normalize

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
	pipenv run python scripts/hugo_new.py new post


.PHONY: convert-notebooks
convert-notebooks:
	pipenv run python scripts/convert_notebooks.py

.PHONY: talk
talk:
	pipenv run python scripts/hugo_new.py new talk

.PHONY: project
project:
	pipenv run python scripts/hugo_new.py new project

.PHONY: featured-image
featured-image:
	pipenv run python scripts/featured_image.py create_image
