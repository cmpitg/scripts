all: generate docs

generate: README.adoc
	ulqui generate-src --from ./ --to bin/
	nim compile --verbosity:0 --define:release bin/src/found_executable_p.nim
	nim compile --verbosity:0 --define:release bin/src/report_missing_executables.nim
	mv bin/src/found_executable_p bin/found-executable-p
	mv bin/src/report_missing_executables bin/report-missing-executables
	chmod +x bin/*

docs: README.adoc
	ulqui generate-html --from ./ --to docs/
