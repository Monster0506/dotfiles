local wk = require("which-key")
-- Leap Keybindings {{{
wk.register(
    {
        s = {"<Plug>(leap-forward)", "Forward Leap"},
        S = {"<Plug>(leap-backward)", "Backward Leap"}
    },
    {prefix = "<leader><leader>"}
)
wk.register(
    {
        s = {"<Plug>(leap-forward)", "Forward Leap"},
        S = {"<Plug>(leap-backward)", "Backward Leap"}
    },
    {prefix = "<leader><leader>", mode = "v"}
)
--- }}}

-- vim:foldmethod=marker foldlevel=0
