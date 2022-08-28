version := $(shell date +"%Y-%m-%d").$(shell git rev-list --count HEAD)

.PHONY: update
update:
	bash -cxe '                                                    \
		git fetch origin                                    && \
		git checkout -b $(version)                          && \
		git checkout -                                      && \
		git rebase "origin/master"                             \
	'
