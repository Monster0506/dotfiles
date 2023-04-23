local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
local wk = require("which-key")
-- Git Keybindings {{{
keymap("n", "<leader>g", "<Cmd>G<CR>", opts)
wk.register(
    {
        name = "git",
        h = {
            name = "hunk",
            s = {"<Cmd>Gitsigns stage_hunk<CR>", "stage"},
            u = {"<Cmd>Gitsigns undo_stage_hunk<CR>", "unstage"}
        },
        d = {"<Cmd>Gdiffsplit<CR>", "View Diff"},
        ["]"] = {"<Cmd>Gitsigns prev_hunk<CR>", "Previous Hunk"},
        ["["] = {"<Cmd>Gitsigns next_hunk<CR>", "Next Hunk"},
        c = {"<Cmd>G commit<CR>", "Commit"},
        a = {"<Cmd>Gwrite<CR>", "Add"},
        w = {"<Cmd>Gwrite<CR>", "Add"},
        r = {"<Cmd>G reset %<CR>", "Reset"},
        l = {"<Cmd>Gclog<CR>", "Log"},
        g = {"<Cmd>0G<CR>", "Status"},
        p = {"<Cmd>Git push<CR>", "Push"},
        P = {"<Cmd>Git push --force<CR>", "Force Push"},
        A = {"<Cmd>Git add --all<CR>", "Add All"},
        R = {"<Cmd>Git reset<CR>", "Reset"},
        u = {"<Cmd>Git undo<CR>", "Undo"}
    },
    {prefix = "<leader>g"}
)
--- }}}

-- vim:foldmethod=marker foldlevel=0
