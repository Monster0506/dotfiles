local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap
-- Center Text on the Screen {{{
local remapList = {
    "p",
    "P",
    "<CR>",
    "gg",
    "H",
    "L",
    "n",
    "N",
    "%",
    "<c-o>",
    "<c-u>",
    "<c-d>",
    "<c-j>",
    "<c-n>",
    "<c-m>",
    "-",
    "+",
    "_"
}

for k in pairs(remapList) do
    keymap("n", remapList[k], remapList[k] .. "zz", opts)
    keymap("v", remapList[k], remapList[k] .. "zz", opts)
end

keymap("n", "j", "v:count == 0 ? 'gjzz' : 'jzz'", {silent = true, expr = true, noremap = true})
keymap("n", "k", "v:count == 0 ? 'gkzz' : 'kzz'", {silent = true, expr = true, noremap = true})
keymap("v", "j", "v:count == 0 ? 'gjzz' : 'jzz'", {silent = true, expr = true, noremap = true})
keymap("v", "k", "v:count == 0 ? 'gkzz' : 'kzz'", {silent = true, expr = true, noremap = true})

--- }}}

-- vim:foldmethod=marker foldlevel=0
