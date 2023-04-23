require("nvim-tree").setup(
    {
        -- {{{
        disable_netrw = false,
        hijack_netrw = false,
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
            icons = {
                glyphs = {
                    default = "",
                    folder = {
                        empty = "",
                        default = "",
                        open = ""
                    }
                }
            },
            indent_markers = {
                enable = true
            }
        },
        filters = {
            -- {{{
            dotfiles = false,
            custom = {"^.git$"}
            -- }}}
        },
        diagnostics = {
            enable = true
        }
        -- }}}
    }
)

-- vim:foldmethod=marker foldlevel=0
