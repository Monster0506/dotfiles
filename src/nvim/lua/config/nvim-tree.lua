require("nvim-tree").setup(
    {
        -- {{{
        view = {
            -- {{{
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
        filters = {
            -- {{{
            dotfiles = false,
            custom = {"^.git$"}
            -- }}}
        }
        -- }}}
    }
)
