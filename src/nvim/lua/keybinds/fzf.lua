local keymap = vim.api.nvim_set_keymap
local wk = require("which-key")
local opts = {noremap = true, silent = true}
wk.add(
    -- FZF {{{
    {
        {"<leader><C-P>", "<Cmd>Files<CR>", desc = "Files"}
    }
)
keymap("n", "<space>h", "<Cmd>History<CR>", opts)
wk.add(
    {
        {"<space>b", "<Cmd>Buffers<CR>", desc = "Buffers"},
        {"<space>h", group = "History"},
        {"<space>h/", "<Cmd>History/<CR>", desc = "Search History"},
        {"<space>h:", "<Cmd>History:<CR>", desc = "Command History"},
        {"<space>l", "<Cmd>Lines<CR>", desc = "Lines"},
        {"<space>w", "<Cmd>Windows<CR>", desc = "Windows"}
    }
)
--- }}}

-- vim:foldmethod=marker foldlevel=0
