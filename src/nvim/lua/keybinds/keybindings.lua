local wk = require("which-key")

local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

-- Keybindings {{{
-- Miscellaneous Mappings {{{
keymap("c", "cd.", "lcd %:p:h<CR>", opts)
keymap("c", "cwd", "lcd %:p:h<CR>", opts)
keymap("i", "<leader><C-i>", "<Cmd>PickEverythingInsert<CR>", opts)
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)
wk.register {
    gV = {'"`[" . strpart(getregtype(), 0, 1) . "`]"', "Visually select changed text", expr = true}
}

wk.register {
    ["<C-t>"] = {"<Cmd>NvimTreeToggle<CR>", "File Tree"}
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
        s = {':<C-R>=(&filetype =~# "lua" ? "luafile %" : "source %")<CR><CR>', "Source file"},
        r = {
            ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>",
            "Modify Registers"
        },
        ["<C-i>"] = {"<Cmd>PickEverythingInsert<CR>", "Pick Everything"},
        t = {
            t = {"<Cmd>Vista nvim_lsp<CR>", "LSP Markers"},
            a = {
                name = "Vista",
                g = {"<Cmd>Vista ctags<CR>", "Ctags"},
                m = {"<Cmd>Vista nvim_lsp<CR>", "LSP Markers"}
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

-- vim:foldmethod=marker foldlevel=0
