local wk = require("which-key")
-- Leap Keybindings {{{
wk.add(
    {
        {"<leader><leader>S", "<Plug>(leap-backward)", desc = "Backward Leap"},
        {"<leader><leader>s", "<Plug>(leap-forward)", desc = "Forward Leap"}
    }
)
--- }}}

-- vim:foldmethod=marker foldlevel=0
