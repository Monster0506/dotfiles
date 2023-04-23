local wk = require("which-key")
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
-- FZF {{{
wk.register(
    {
        ["<C-P>"] = {"<Cmd>Files<CR>", "Files"}
    },
    {prefix = "<leader>"}
)
keymap("n", "<space>h", "<Cmd>History<CR>", opts)
wk.register(
    {
        h = {
            name = "History",
            ["/"] = {"<Cmd>History/<CR>", "Search History"},
            [":"] = {"<Cmd>History:<CR>", "Command History"}
        },
        b = {"<Cmd>Buffers<CR>", "Buffers"},
        w = {"<Cmd>Windows<CR>", "Windows"},
        l = {"<Cmd>Lines<CR>", "Lines"}
    },
    {prefix = "<space>"}
)
--- }}}

-- vim:foldmethod=marker foldlevel=0
