all: generate docs

generate:
	ulqui generate-src --from . --to bin/
	chmod +x bin/*

docs:
	ulqui generate-html --from . --to docs/
