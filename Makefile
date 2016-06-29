all: generate docs

generate: README.adoc
	ulqui generate-src --from ./ --to bin/
	cd bin && crystal compile --release src/found-executable-p.cr
	nim compile --verbosity:0 --define:release bin/src/report_missing_executables.nim
	mv bin/src/report_missing_executables bin/report-missing-executables
	chmod +x bin/*

docs: README.adoc
	ulqui generate-html --from ./ --to docs/
