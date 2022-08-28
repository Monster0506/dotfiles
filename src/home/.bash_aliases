#!/usr/bin/bash
# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls -plFCGA --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi
alias tree='tree -CF'
alias config='/usr/bin/git --git-dir=/home/tj/.cfg/ --work-tree=/home/tj'
alias sl=ls
# some more ls aliases
# alias ll='ls -lF'
# alias l='ls -CF'
alias so=source
alias cd..="cd .."
# Add an "alert" alias for long running commands.  Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias vim=nvim
alias cls=clear
alias open=xdg-open
alias g++=gplusplus

alias sudo='sudo '
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias rm="Trash"

alias ls="exa --classify -a"
alias ll="exa --classify -a --long --git"

alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias lg=lazygit
