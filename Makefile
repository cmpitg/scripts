all: generate docs

generate: README.adoc
	ulqui generate-src --from . --to bin/
	nim compile --verbosity:0 --define:release bin/src/found_executable_p.nim
	mv bin/src/found_executable_p bin/found-executable-p
	chmod +x bin/*

docs: README.adoc
	ulqui generate-html --from . --to docs/
