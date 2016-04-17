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

.PHONY: serve_draft_workaround
serve_draft_workaround:
	./serve_drafts_workaround.sh

.PHONY: devel
devel:
	make serve | conscript chromereload 4000

.PHONY: please_publish
please_publish:
	echo bump >> publication_frustration.txt
	gpc please publish
