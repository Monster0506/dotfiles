set -g prefix ^B
set -g prefix2 F12
bind b send-prefix
unbind-key -n C-a
unbind-key -n C-d
unbind-key -n C-b
bind C-e new-window -n 'config' "sh -c '\${EDITOR:-nvim} ~/.byobu/.tmux.conf && byobu source ~/.byobu.tmux.conf && byobu display \"Config reloaded\"'"
bind | split-window -h -c "#{pane_current_path}"
unbind '-'
bind - split-window -v -c "#{pane_current_path}"
bind _ split-window -v -c "#{pane_current_path}"
bind + resize-pane -Z
bind h select-pane -L
bind l select-pane -R
