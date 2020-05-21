.PHONY: cleanall all generate generate-anew docs

all: generate docs

generate: README.adoc
	ulqui generate-src --from ./ --to bin/
	find bin/ -type f -print0 | xargs -0 -I{} chmod +x "{}"

generate-anew: README.adoc
	ulqui generate-src --from ./ --to bin-new/
	find bin-new/ -type f -print0 | xargs -0 -I{} chmod +x "{}"

docs: README.adoc
	ulqui generate-html --from ./ --to docs/

cleanall:
	rm -rf bin
	rm -rf docs
