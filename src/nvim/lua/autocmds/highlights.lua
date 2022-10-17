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
    --- }}}
    --- }}}
