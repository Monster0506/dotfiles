-- Autocmds {{{
-- Fold Init.lua when sourced, read, or saved with markers {{{
vim.api.nvim_create_autocmd(
    {"BufRead", "BufWrite", "SourceCmd", "BufEnter"},
    {
        pattern = vim.fn.expand "$MYVIMRC",
        command = "setlocal foldmethod=marker "
    }
)
--- }}}
-- Format on save {{{
vim.api.nvim_create_autocmd(
    {
        "BufWritePre"
    },
    {
        pattern = "*",
        command = "silent Neoformat | silent! undojoin"
    }
)
--- }}}
-- Open NvimTree on startup {{{
local function open_nvim_tree()
    -- open the tree
    require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({"VimEnter"}, {callback = open_nvim_tree})
-- }}}
--- }}}
