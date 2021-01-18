rev ?=

version := $(shell date +"%Y-%m-%d").$(shell git rev-list --count HEAD)

## macro

define get-latest-commit
#! /usr/bin/env bash
set -eo pipefail

DEBUG="$${DEBUG:-}"

log() {
  echo "$$1" 1>&2
}

get_hydra_builds() {
  curl -sfL https://hydra.nixos.org/jobset/nixpkgs/trunk \
    | grep -F 'nixpkgs → '                               \
    | sed -E 's|^.*<tt>([^<]+)</tt>.*$$|\1|g'
}

resolve_commit() {
  log "resolving commit $$1"
  curl -sfL "https://github.com/NixOS/nixpkgs/commit/$$1.patch" | head -n 1 | cut -d' ' -f2
}

if [ ! -z "$$DEBUG" ]
then
  log "turning on debug mode"
  set -x
fi

if [ -z "$$rev" ]
then
  for short_commit in $$(get_hydra_builds)
  do
    commit=$$(resolve_commit "$$short_commit" || true)
    if [ -z "$$commit" ]
    then
      log "commit $$short_commit was not resolved, skipping towards next"
    else
      log "commit $$short_commit was resolved into $$commit"
      break
    fi
  done
  
  echo "$$commit"
else
  resolve_commit "$$rev"
fi
endef

## targets

.PHONY: update
update:
	bash -cxe '                                                    \
		git fetch origin                                    && \
		git checkout -b $(version)                          && \
		git checkout -                                      && \
		git rebase "$$(make get-latest-commit | grep -v :)" && \
		git push corpix $(version) +corpix:master              \
	'

.PHONY: get-latest-commit
.ONESHELL:
get-latest-commit:
	@$(get-latest-commit)
