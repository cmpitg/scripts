.PHONY: cleanall

all: generate docs

generate: README.adoc
	ulqui generate-src --from ./ --to bin/
	cd bin && crystal compile --release src/found-executable-p.cr
	cd bin && crystal compile --release src/report-missing-executables.cr
	chmod +x bin/*

docs: README.adoc
	ulqui generate-html --from ./ --to docs/

cleanall:
	rm -rf bin
	rm -rf docs
