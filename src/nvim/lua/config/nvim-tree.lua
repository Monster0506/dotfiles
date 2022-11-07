require("nvim-tree").setup(
    {
        -- {{{
        disable_netrw = true,
        open_on_setup = true,
        open_on_setup_file = true,
        sync_root_with_cwd = true,

        view = {
            -- {{{
            centralize_selection = true,
            side = "right",
            mappings = {
                -- {{{
                list = {
                    -- {{{
                    {key = "<C-t>", action = "close"},
                    {key = "u", action = "dir_up"}
                    -- }}}
                }
                -- }}}
            }
            -- }}}
        },
        renderer = {
            add_trailing = true,
            highlight_git = true,
            highlight_opened_files = "all",

        },
        filters = {
            -- {{{
            dotfiles = false,
            custom = {"^.git$"}
            -- }}}
        },
        diagnostics = {
            enable = true,

        },
        -- }}}
    }
)
