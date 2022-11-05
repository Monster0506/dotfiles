-- Autocmds {{{
-- Fold Init.lua when sourced, read, or saved with markers {{{
vim.api.nvim_create_autocmd(
    {"BufRead", "BufWrite", "SourceCmd", "BufEnter"},
    {
        pattern = vim.fn.expand "$MYVIMRC",
        command = "set foldmethod=marker "
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
--- }}}
