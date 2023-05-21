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
