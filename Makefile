.PHONY: help
help:
	@ echo
	@ echo Targets:
	@ echo
	@ grep ^[a-z] Makefile | sed 's/^/    /; s/://'
	@ echo

.PHONY: serve
serve:
	bundle exec jekyll serve --watch --drafts # --incremental

devel:
	commando -p cat -j -q \
		| grep --line-buffered html \
		| conscript chromereload 4000
