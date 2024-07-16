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
wk.add(
    {
        {"<space>ff", "<Cmd>Telescope fd<CR>", desc = "Find Files", group = "Files"},
        {
            "<space>fg",
            "<Cmd>lua require('telescope.builtin').live_grep(No_preview())<CR>",
            desc = "Grep in Files",
            group = "Files"
        },
        {"<space>fo", "<Cmd>Telescope oldfiles<CR>", desc = "Open Recent File", group = "Files"},
        {"<space>k", "<CMD>Telescope keymaps<CR>", desc = "Keymaps"},
        {"<space>q", "<CMD>Telescope quickfix<CR>", desc = "Quickfix"},
        {"<space>uT", "<Cmd>Telescope undo<CR>", desc = "Undo Menu", group = "Undo"},
        {"<space>ut", "<Cmd>MundoToggle<CR>", desc = "Undo Tree", group = "Undo"}
    }
)
wk.add(
    {
        {"<C-p>", "<Cmd>Telescope fd<CR>", desc = "Files"},
        {"<leader>gf", "<Cmd>Telescope git_files<CR>", desc = "Git Files"}
    }
)
--- }}}

-- vim:foldmethod=marker foldlevel=0
