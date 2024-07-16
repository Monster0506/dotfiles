local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
local wk = require("which-key")
-- Window Resizing/Movement {{{
-- Resize splits
keymap("n", "<C-Up>", "<Cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<Cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", opts)
-- Change split orientation
keymap("n", "<M-Right>", "<Cmd>tabnext<CR>", opts)
keymap("n", "<M-Left>", "<Cmd>tabprevious<CR>", opts)
wk.add(
    {
    { ",h", "<c-w>t<c-w>K", desc = "Split Horizontally" },
    { ",v", "<c-w>t<c-w>H", desc = "Split Vertically" },
    }
)
--- }}}

-- vim:foldmethod=marker foldlevel=0
