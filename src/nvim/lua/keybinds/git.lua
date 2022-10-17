local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
local wk = require("which-key")
-- Git Keybindings {{{
keymap("n", "<leader>g", "<CMD>G<CR>", opts)
wk.register(
    {
        g = {
            name = "git",
            h = {
                name = "hunk",
                s = {"<cmd>Gitsigns stage_hunk<CR>", "stage"},
                u = {"<cmd>Gitsigns undo_stage_hunk<CR>", "unstage"}
            },
            d = {"<CMD>Gdiffsplit<CR>", "View Diff"},
            ["]"] = {"<CMD>Gitsigns prev_hunk<CR>", "Previous Hunk"},
            ["["] = {"<CMD>Gitsigns next_hunk<CR>", "Next Hunk"},
            c = {"<CMD>G commit<CR>", "Commit"},
            a = {"<CMD>G add %<CR>", "Add"},
            r = {"<CMD>G reset %<CR>", "Reset"}
        }
    },
    {prefix = "<leader>"}
)
--- }}}
