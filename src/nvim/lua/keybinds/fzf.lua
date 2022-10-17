local wk = require("which-key")
-- FZF {{{
wk.register(
    {
        ["<C-P>"] = {"<cmd>Files<CR>", "Files"}
    }
)
wk.register(
    {
        ["<C-p>"] = {"<cmd>Commands<CR>", "Commands"}
    },
    {prefix = "<leader>"}
)
--- }}}
