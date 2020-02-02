.PHONY: cleanall all

all: generate docs

generate: README.adoc
	ulqui generate-src --from ./ --to bin/
	chmod +x bin/**/*

docs: README.adoc
	ulqui generate-html --from ./ --to docs/

cleanall:
	rm -rf bin
	rm -rf docs
