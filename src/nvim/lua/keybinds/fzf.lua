local wk = require("which-key")
-- FZF {{{
wk.register(
    {
        ["<C-P>"] = {"<Cmd>Files<CR>", "Files"}
    }
)
wk.register(
    {
        ["<C-p>"] = {"<Cmd>Commands<CR>", "Commands"}
    },
    {prefix = "<leader>"}
)
--- }}}
