local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
local wk = require("which-key")
-- Telescope Mappings {{{
keymap("n", "<space>h", "<Cmd>History<CR>", opts)
wk.register(
    {
        u = {
            name = "undo",
            T = {"<Cmd>Telescope undo<CR>", "Undo Menu"},
            t = {"<Cmd>MundoToggle<CR>", "Undo Tree"}
        },
        h = {
            name = "History",
            ["/"] = {"<Cmd>History/<CR>", "Search History"},
            [":"] = {"<Cmd>History:<CR>", "Command History"}
        },
        m = {"<Cmd>Maps<CR>", "Mappings"},
        b = {"<Cmd>Buffers<CR>", "Buffers"},
        w = {"<Cmd>Windows<CR>", "Windows"}
    },
    {prefix = "<space>"}
)
--- }}}
