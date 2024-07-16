local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
local wk = require("which-key")
-- Git Keybindings {{{
keymap("n", "<leader>g", "<Cmd>G<CR>", opts)
wk.add(
    {
        {"<leader>g", group = "git"},
        {"<leader>gA", "<Cmd>Git add --all<CR>", desc = "Add All"},
        {"<leader>gP", "<Cmd>Git push --force<CR>", desc = "Force Push"},
        {"<leader>gR", "<Cmd>Git reset<CR>", desc = "Reset"},
        {"<leader>g[", "<Cmd>Gitsigns next_hunk<CR>", desc = "Next Hunk"},
        {"<leader>g]", "<Cmd>Gitsigns prev_hunk<CR>", desc = "Previous Hunk"},
        {"<leader>ga", "<Cmd>Gwrite<CR>", desc = "Add"},
        {"<leader>gc", "<Cmd>G commit<CR>", desc = "Commit"},
        {"<leader>gd", "<Cmd>Gdiffsplit<CR>", desc = "View Diff"},
        {"<leader>gg", "<Cmd>0G<CR>", desc = "Status"},
        {"<leader>gh", group = "hunk"},
        {"<leader>ghs", "<Cmd>Gitsigns stage_hunk<CR>", desc = "stage"},
        {"<leader>ghu", "<Cmd>Gitsigns undo_stage_hunk<CR>", desc = "unstage"},
        {"<leader>gl", "<Cmd>Gclog<CR>", desc = "Log"},
        {"<leader>gp", "<Cmd>Git push<CR>", desc = "Push"},
        {"<leader>gr", "<Cmd>G reset %<CR>", desc = "Reset"},
        {"<leader>gu", "<Cmd>Git undo<CR>", desc = "Undo"},
        {"<leader>gw", "<Cmd>Gwrite<CR>", desc = "Add"}
    }
)
--- }}}

-- vim:foldmethod=marker foldlevel=0
