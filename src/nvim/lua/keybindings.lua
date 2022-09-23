local M = {}

local wk = require("which-key")

function M.setup()
    local opts = {noremap = true, silent = true}
    local keymap = vim.api.nvim_set_keymap

    -- Keybindings {{{
    -- Window Resizing/Movement {{{
    -- Resize splits
    keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
    keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
    keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
    keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)
    -- Change split orientation
    keymap("n", "<M-Right>", "<cmd>tabnext<CR>", opts)
    keymap("n", "<M-Left>", "<cmd>tabprevious<CR>", opts)
    wk.register(
        {
            v = {"<c-w>t<c-w>H", "Split Vertically"},
            h = {"<c-w>t<c-w>K", "Split Horizontally"}
        },
        {prefix = ","}
    )
    --- }}}
    -- FZF {{{
    keymap("n", "<C-p>", "<cmd>Files<CR>", opts)
    wk.register(
        {
            ["<C-p>"] = {"<cmd>Commands<CR>", "Commands"}
        },
        {prefix = "<leader>"}
    )
    --- }}}
    -- Bracket expansion {{{
    keymap("i", "(<CR>", "(<CR>)<Esc>O", opts)
    keymap("i", "(;", "(<CR>);<Esc>O", opts)
    keymap("i", "(,", "(<CR>),<Esc>O", opts)
    keymap("i", "{<CR>", "{<CR>}<Esc>O", opts)
    keymap("i", "{;", "{<CR>};<Esc>O", opts)
    keymap("i", "{,", "{<CR>},<Esc>O", opts)
    keymap("i", "[<CR>", "[<CR>]<Esc>O", opts)
    keymap("i", "[;", "[<CR>];<Esc>O", opts)
    keymap("i", "[,", "[<CR>],<Esc>O", opts)
    --- }}}
    -- Center Text on the Screen {{{
    local remapList = {"p", "P", "<CR>", "gg", "H", "L", "n", "N", "%", "<c-o>", "<c-u>", "<c-d>"}

    for k in pairs(remapList) do
        keymap("n", remapList[k], remapList[k] .. "zz", opts)
        keymap("v", remapList[k], remapList[k] .. "zz", opts)
    end
    keymap("n", "j", "v:count == 0 ? 'gjzz' : 'jzz'", {silent = true, expr = true, noremap = true})
    keymap("n", "k", "v:count == 0 ? 'gkzz' : 'kzz'", {silent = true, expr = true, noremap = true})
    keymap("v", "j", "v:count == 0 ? 'gjzz' : 'jzz'", {silent = true, expr = true, noremap = true})
    keymap("v", "k", "v:count == 0 ? 'gkzz' : 'kzz'", {silent = true, expr = true, noremap = true})

    --- }}}
    -- Miscellaneous Mappings {{{
    keymap("n", "<leader>t", "<cmd>Vista nvim_lsp<CR>", opts)
    keymap("i", ":check:", "✓", opts)
    keymap("n", "+", "<C-a>", opts)
    keymap("n", "<C-t>", "<cmd>NvimTreeToggle<CR>", opts)
    keymap("n", "<F2>", "<cmd>setlocal spell! spelllang=en_us<CR>", opts)
    keymap("c", "cd.", "lcd %:p:h<CR>", opts)
    keymap("c", "cwd", "lcd %:p:h<CR>", opts)
    keymap("i", "<leader><C-i>", "<cmd>PickEverythingInsert<CR>", opts)
    keymap("x", "<", "<gv", opts)
    keymap("x", ">", ">gv", opts)
    wk.register(
        {
            M = {require("ufo").closeAllFolds, "Close All Folds"},
            R = {require("ufo").openAllFolds, "Open All Folds"}
        },
        {prefix = "z"}
    )

    wk.register(
        {
            t = {"<cmd>FloatermToggle<CR>", "New Terminal"},
            r = {"<cmd>FloatermNew ranger<CR>", "Ranger"},
            u = {"<cmd>MundoToggle<CR>", "Undo Menu"}
        },
        {prefix = "<space>"}
    )
    wk.register(
        {
            t = {"<cmd>FloatermNew<CR>", "New Terminal"}
        },
        {prefix = "<space>", mode = "x"}
    )

    wk.register(
        {
            l = {
                ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>",
                "Modify Registers"
            },
            ["<C-i>"] = {"<cmd>PickEverythingInsert<CR>", "Pick Everything"},
            t = {
                name = "Vista",
                a = {
                    name = "Vista",
                    g = {"<cmd>Vista ctags<CR>", "Ctags"},
                    m = {"<cmd>Vista nvim_lsp", "LSP Markers"}
                }
            },
            y = {'"+y', "Yank to Clipboard"}
        },
        {prefix = "<leader>"}
    )
    --- }}}
    -- Leap Keybindings {{{
    wk.register(
        {
            s = {"<Plug>(leap-forward)", "Forward Leap"},
            S = {"<Plug>(leap-backward)", "Backward Leap"}
        },
        {prefix = "<leader><leader>"}
    )
    wk.register(
        {
            s = {"<Plug>(leap-forward)", "Forward Leap"},
            S = {"<Plug>(leap-backward)", "Backward Leap"}
        },
        {prefix = "<leader><leader>", mode = "v"}
    )
    --- }}}
    -- Telescope Mappings {{{
    keymap("n", "<space>h", "<cmd>History<CR>", opts)
    wk.register(
        {
            h = {
                name = "History",
                ["/"] = {"<cmd>History/<CR>", "Search History"},
                [":"] = {"<cmd>History:<CR>", "Command History"}
            },
            m = {"<cmd>Maps<CR>", "Mappings"},
            b = {"<cmd>Buffers<CR>", "Buffers"},
            w = {"<cmd>Windows<CR>", "Windows"}
        },
        {prefix = "<space>"}
    )
    --- }}}
    -- LSP Mappings {{{
    wk.register(
        {
            ["["] = {
                g = {
                    vim.diagnostic.goto_prev,
                    "Previous Diagnostic"
                }
            },
            ["]"] = {
                g = {
                    vim.diagnostic.goto_next,
                    "Next Diagnostic"
                }
            }
        }
    )
    wk.register(
        {
            e = {
                vim.diagnostic.open_float,
                "View Float"
            },
            q = {vim.diagnostic.setloclist, "View Diagnostics"}
        },
        {prefix = "<leader>"}
    )
    --- }}}
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
    --- }}}
end

return M
