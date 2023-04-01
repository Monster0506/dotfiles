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
-- Crates {{{
vim.api.nvim_create_autocmd(
    "BufRead",
    {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", {clear = true}),
        pattern = "Cargo.toml",
        callback = function()
            require("cmp").setup.buffer({sources = {{name = "crates"}}})
        end
    }
)
-- }}}
--- }}}
