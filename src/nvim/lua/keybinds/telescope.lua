local wk = require("which-key")
No_preview = function()
    return require("telescope.themes").get_dropdown(
        {
            borderchars = {
                {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
                prompt = {"─", "│", " ", "│", "┌", "┐", "│", "│"},
                results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
                preview = {"─", "│", "─", "│", "┌", "┐", "┘", "└"}
            },
            width = 0.8,
            previewer = false,
            prompt_title = false
        }
    )
end
-- Telescope Mappings {{{
wk.register(
    {
        u = {
            name = "undo",
            T = {"<Cmd>Telescope undo<CR>", "Undo Menu"},
            t = {"<Cmd>MundoToggle<CR>", "Undo Tree"}
        },
        f = {
            name = "Files",
            f = {"<Cmd>Telescope fd<CR>", "Find Files"},
            o = {"<Cmd>Telescope oldfiles<CR>", "Open Recent File"},
            g = {"<Cmd>lua require('telescope.builtin').live_grep(No_preview())<CR>", "Grep in Files"}
        },
        q = {"<CMD>Telescope quickfix<CR>", "Quickfix"},
        k = {"<CMD>Telescope keymaps<CR>", "Keymaps"}
    },
    {prefix = "<space>"}
)
wk.register(
    {
        ["<C-p>"] = {"<Cmd>Telescope fd<CR>", "Files"},
        ["<leader>gf"] = {"<Cmd>Telescope git_files<CR>", "Git Files"}
    }
)
--- }}}

-- vim:foldmethod=marker foldlevel=0
