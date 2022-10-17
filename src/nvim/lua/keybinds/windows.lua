local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
local wk = require("which-key")
-- Window Resizing/Movement {{{
-- Resize splits
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)
-- Change split orientation
keymap("n", "<M-Right>", "<cmd>tabnext<CR>", opts)
keymap("n", "<M-Left>", "<cmd>tabprevious<CR>", opts)
wk.register(
    {
        v = {"<c-w>t<c-w>H", "Split Vertically"},
        h = {"<c-w>t<c-w>K", "Split Horizontally"}
    },
    {prefix = ","}
)
--- }}}
