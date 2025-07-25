#!/usr/bin bash
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
export PATH=""
source ${HOME}/.profile

export NUMBERRE='^[0-9]+$'
export CONTAINSNUMBERRE='.+[0-9].+'
export black="\033[0;38;5;0m"
export red="\033[0;38;5;1m"
export orange="\033[0;38;5;130m"
export green="\033[0;38;5;2m"
export yellow="\033[0;38;5;3m"
export blue="\033[0;38;5;4m"
export bblue="\033[0;38;5;12m"
export magenta="\033[0;38;5;55m"
export cyan="\033[0;38;5;6m"
export white="\033[0;38;5;7m"
export coldblue="\033[0;38;5;33m"
export smoothblue="\033[0;38;5;111m"
export iceblue="\033[0;38;5;45m"
export turqoise="\033[0;38;5;50m"
export smoothgreen="\033[0;38;5;42m"
export morered="\033[0;38;5;50m"

set -o vi
# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000000
export HISTFILESIZE=""
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:history:clear"
shopt -s cmdhist
export HISTTIMEFORMAT="%F %T  "
bind "set mark-symlinked-directories on"
bind '"\e[B": history-search-forward'
bind '"\e[A": history-search-backward'
bind Space:magic-space
bind "set completion-map-case on"
bind "set completion-ignore-case on"
bind "set mark-symlinked-directories on"
# colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'        # end the info box
export LESS_TERMCAP_so=$'\E[01;42;30m' # begin the info box
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s autocd 2>/dev/null

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)" || true

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z ${debian_chroot:-} ]] && [[ -r /etc/debian_chroot ]]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "${TERM}" in
xterm-color)
	color_prompt=yes
	;;
*-256color)
	color_prompt=yes
	;;
*)
	exit
	;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [[ -n ${force_color_prompt} ]]; then
	if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [[ ${color_prompt} == yes ]]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# You may want to put all your additions into a separate file like
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [[ -f ${HOME}/.bash_aliases ]]; then
	. ${HOME}/.bash_aliases
fi

if [[ -f ${HOME}/.bash_completions ]]; then
	. ${HOME}/.bash_completions
fi

if [[ -f ${HOME}/.bash_functions ]]; then
	. ${HOME}/.bash_functions
fi

if [[ -f ${HOME}/.fehbg ]]; then
	. ${HOME}/.fehbg
fi

#include dotfiles in wildcard expansion, and match case-insensitively
shopt -s dotglob
shopt -s nocaseglob
# don't use the shell's built-in history mechanism
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
	. /usr/share/bash-completion/bash_completion
fi

if [[ -f "${HOME}"/.git-completion.bash ]]; then
	. "${HOME}"/.git-completion.bash
fi

if [[ -f "${HOME}"/.xprofile ]]; then
	. "${HOME}"/.xprofile
fi

# Evaluations
eval "$(starship init bash)" || true
. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"
