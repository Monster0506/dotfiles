local M = {}
function M.setup()
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
    -- Highlight line in normal mode {{{
    -- Highlight {{{
    vim.api.nvim_create_autocmd(
        {
            "VimEnter",
            "InsertLeave",
            "WinEnter"
        },
        {
            pattern = "*",
            command = "set cursorline"
        }
    )
    --- }}}
    -- Remove cursorline {{{
    vim.api.nvim_create_autocmd(
        {
            "VimLeave",
            "InsertEnter",
            "WinLeave"
        },
        {
            pattern = "*",
            command = "set nocursorline"
        }
    )
    -- }}}
    --- }}}
    -- Make Vim Create Parent Directories on Save {{{
    -- See https://github.com/jghauser/mkdir.nvim/blob/main/lua/mkdir.lua

    local luafunc = function()
        local dir = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end

    vim.api.nvim_create_autocmd(
        {
            "BufWritePre"
        },
        {
            pattern = "*",
            callback = luafunc
        }
    )

    --- }}}
    -- Auto-Compile COQsnips {{{
    vim.api.nvim_create_autocmd(
        {
            "FileType coq-snip",
            "BufWrite"
        },
        {
            pattern = "*.snip",
            command = "COQsnips compile"
        }
    )

    --- }}}
    --- }}}
end

return M
