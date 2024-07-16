local wk = require("which-key")

local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

-- Keybindings {{{
--- }}}
-- Miscellaneous Mappings {{{
keymap("c", "cd.", "lcd %:p:h<CR>", opts)
keymap("c", "cwd", "lcd %:p:h<CR>", opts)
keymap("i", "<leader><C-i>", "<Cmd>PickEverythingInsert<CR>", opts)
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)
wk.add {
    {
        "gV",
        '"`[" . strpart(getregtype(), 0, 1) . "`]"',
        desc = "Visually select changed text",
        expr = true,
        replace_keycodes = false
    }
}

wk.add {
    {"<C-t>", "<Cmd>NvimTreeToggle<CR>", desc = "File Tree"}
}
wk.add(
    {
        {"zM", require("ufo").closeAllFolds, desc = "Close All Folds"},
        {"zR", require("ufo").openAllFolds, desc = "Open All Folds"}
    }
)

wk.add(
    {
        {
            "<leader><C-i>",
            "<Cmd>PickEverythingInsert<CR>",
            desc = "Pick Everything"
        },
        {
            "<leader><Space>O",
            "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
            desc = "Put empty line above"
        },
        {
            "<leader><Space>o",
            "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>",
            desc = "Put empty line below"
        },
        {
            "<leader>r",
            ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>",
            desc = "Modify Registers"
        },
        {
            "<leader>s",
            ':<C-R>=(&filetype =~# "lua" ? "luafile %" : "source %")<CR><CR>',
            desc = "Source file"
        },
        {
            "<leader>tag",
            "<Cmd>Vista ctags<CR>",
            group = "Vista",
            desc = "Ctags"
        },
        {
            "<leader>tam",
            "<Cmd>Vista nvim_lsp<CR>",
            group = "Vista",
            desc = "LSP Markers"
        },
        {
            "<leader>tt",
            "<Cmd>Vista nvim_lsp<CR>",
            group = "Vista",
            desc = "LSP Markers"
        },
        {
            "<leader>y",
            '"+y',
            desc = "Yank to Clipboard"
        }
    }
)
--- }}}
-- vim:foldmethod=marker foldlevel=0
