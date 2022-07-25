.DEFAULT_GOAL := install

SUDO := $(shell command -v sudo 2> /dev/null)
APT := $(shell command -v apt 2> /dev/null)
GIT := $(shell command -v git 2> /dev/null)



install: generate

sync: preq
	@echo "~>> [[ SYNC ]] <<~"
	@sync
update: sync

generate: preq
	@echo "~>> [[ DOTFILES ]] <<~"
	@bootstrap

final: preq
	finalSteps

preq:
ifndef SUDO
	$(error No sudo in $$PATH.)
endif
ifndef APT
	$(error No apt in $$PATH.)
endif
ifndef GIT
	$(error No GIT in $$PATH.)
endif
