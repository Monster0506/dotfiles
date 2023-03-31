# Setup fzf
# ---------
if [[ ! "$PATH" == *${HOME}/bin* ]]; then
  PATH="${PATH:+${PATH}:}${HOME}/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOME}/shell/completion.bash" 2>/dev/null

# Key bindings
# ------------
source "${HOME}/shell/key-bindings.bash"
