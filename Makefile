.DEFAULT_GOAL := all

SUDO := $(shell command -v sudo 2> /dev/null)
APT := $(shell command -v apt 2> /dev/null)
GIT := $(shell command -v git 2> /dev/null)



all: generate finalAll

install: generate

sync: preq
	@echo "~>> [[ SYNC ]] <<~"
	@./script/sync
update: sync

generate: preq
	@echo "~>> [[ DOTFILES ]] <<~"
	@./script/bootstrap

final: preq
	@./script/finalSteps

finalAll: preq
	@./script/finalSteps -n

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
