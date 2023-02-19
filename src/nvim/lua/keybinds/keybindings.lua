local wk = require("which-key")

local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

-- Keybindings {{{
-- Miscellaneous Mappings {{{
-- keymap("n", "<F1>", "<cmd>setlocal spell! spelllang=en_us<CR>", opts)
keymap("c", "cd.", "lcd %:p:h<CR>", opts)
keymap("c", "cwd", "lcd %:p:h<CR>", opts)
keymap("i", "<leader><C-i>", "<cmd>PickEverythingInsert<CR>", opts)
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)
wk.register {
    gV = {'"`[" . strpart(getregtype(), 0, 1) . "`]"', "Visually select changed text", expr = true}
}

wk.register {
    ["<C-t>"] = {"<cmd>NvimTreeToggle<CR>", "File Tree"}
}
wk.register(
    {
        M = {require("ufo").closeAllFolds, "Close All Folds"},
        R = {require("ufo").openAllFolds, "Open All Folds"}
    },
    {prefix = "z"}
)

wk.register(
    {
        l = {
            ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>",
            "Modify Registers"
        },
        ["<C-i>"] = {"<cmd>PickEverythingInsert<CR>", "Pick Everything"},
        t = {
            t = {"<cmd>Vista nvim_lsp<CR>", "LSP Markers"},
            a = {
                name = "Vista",
                g = {"<cmd>Vista ctags<CR>", "Ctags"},
                m = {"<cmd>Vista nvim_lsp<CR>", "LSP Markers"}
            }
        },
        y = {'"+y', "Yank to Clipboard"},
        ["<Space>"] = {
            O = {"<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", "Put empty line above"},
            o = {"<Cmd>call append(line('.'), repeat([''], v:count1))<CR>", "Put empty line below"}
        }
    },
    {prefix = "<leader>"}
)
--- }}}
--- }}}
