local nvim_tmux_nav = require("nvim-tmux-navigation")

nvim_tmux_nav.setup {
    disable_when_zoomed = true,
    keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>"
    }
}

-- vim:foldmethod=marker foldlevel=0
