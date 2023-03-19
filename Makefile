.DEFAULT_GOAL := all

SUDO := $(shell command -v sudo 2> /dev/null)
APT := $(shell command -v pacman 2> /dev/null)
GIT := $(shell command -v git 2> /dev/null)



all: generate finalAll gitConfig

install: generate

sync: preq
	@echo -e "\e[32m~>> [[ SYNC ]] <<~\e[0m"
	@./script/sync
update: sync

generate: preq
	@echo -e "\e[32m~>> [[ DOTFILES ]] <<~\e[0m"
	@./script/bootstrap

final: preq
	@./script/finalSteps

finalAll: preq
	@./script/finalSteps -n

gitConfig: preq
	@./script/gitConfig

preq:
ifndef SUDO
	$(error No sudo in $$PATH.)
endif
ifndef APT
	$(error No pacman in $$PATH.)
endif
ifndef GIT
	$(error No GIT in $$PATH.)
endif

purge: preq
	@./script/purge
