local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap
-- Bracket expansion {{{
keymap("i", "(<CR>", "(<CR>)<Esc>O", opts)
keymap("i", "(;", "(<CR>);<Esc>O", opts)
keymap("i", "(,", "(<CR>),<Esc>O", opts)
keymap("i", "{<CR>", "{<CR>}<Esc>O", opts)
keymap("i", "{;", "{<CR>};<Esc>O", opts)
keymap("i", "{,", "{<CR>},<Esc>O", opts)
keymap("i", "[<CR>", "[<CR>]<Esc>O", opts)
keymap("i", "[;", "[<CR>];<Esc>O", opts)
keymap("i", "[,", "[<CR>],<Esc>O", opts)
--- }}}
