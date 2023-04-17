if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi
ZDOTDIR=~/.zsh
source <(/usr/local/bin/starship init zsh --print-full-init)
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
eval "$(pip completion --zsh)"

case $- in
*i*) ;;
*) ;;
esac

source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load
HISTORY_IGNORE="(&|[ ]*|exit|ls|history|clear|cd|cd..|cd ..)"
HYPHEN_INSENSITIVE=true
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=100000
COMPLETION_WAITING_DOTS=true

export EDITOR="nvim"
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"
export HISTCONTOL="erasedups:ignoreboth"
# colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'        # end the info box
export LESS_TERMCAP_so=$'\E[01;42;30m' # begin the info box
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

PATH=""
source ~/.profile
source ~/.zsh/zsh_aliases
source ~/.zsh/zsh_functions
source ~/.zsh/plugins.zsh
. "$HOME/.cargo/env"

setopt VI
setopt EXTENDED_HISTORY
setopt EXTENDED_GLOB
setopt NO_CASE_GLOB
setopt APPEND_HISTORY
setopt AUTO_CD
setopt AUTO_PUSHD
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt CORRECT
setopt CORRECT_ALL
setopt INTERACTIVE_COMMENTS

# zstyle :compinstall filename '/home/tj/.zshrc'

# autoload -Uz compinit
# compinit

bindkey -v
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey " " magic-space
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -f ${HOME}/.bash_aliases ]] && . ${HOME}/.bash_aliases
