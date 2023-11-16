.PHONY: help
help:
	@ echo
	@ echo Targets:
	@ echo
	@ grep ^[a-z] Makefile | sed 's/^/    /; s/://'
	@ echo

.PHONY: serve
serve:
	@echo ""
	@echo ""
	@echo "Spinning up on http://localhost:4000"
	@echo ""
	@echo ""
	docker-compose up blog

new-post:
	docker-compose run -e NEW_POST=t new-post

