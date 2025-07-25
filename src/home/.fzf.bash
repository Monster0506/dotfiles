# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tj/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tj/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/tj/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/tj/shell/key-bindings.bash"
