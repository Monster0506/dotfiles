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
