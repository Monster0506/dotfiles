local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
local wk = require("which-key")
-- Telescope Mappings {{{
keymap("n", "<space>h", "<cmd>History<CR>", opts)
wk.register(
    {
        h = {
            name = "History",
            ["/"] = {"<cmd>History/<CR>", "Search History"},
            [":"] = {"<cmd>History:<CR>", "Command History"}
        },
        m = {"<cmd>Maps<CR>", "Mappings"},
        b = {"<cmd>Buffers<CR>", "Buffers"},
        w = {"<cmd>Windows<CR>", "Windows"}
    },
    {prefix = "<space>"}
)
--- }}}
