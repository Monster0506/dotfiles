local wk = require("which-key")

wk.add(
    {
        {
            "<leader>tb",
            '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"; print(vim.o.bg)<CR>',
            desc = "Toggle 'background'",
            group = "Toggle"
        },
        {
            "<leader>tcc",
            "<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>",
            desc = "Toggle 'cursorcolumn'",
            group = "Cursor"
        },
        {"<leader>tcl", "<Cmd>setlocal cursorline! cursorline?<CR>", desc = "Toggle 'cursorline'", group = "Cursor"},
        {"<leader>tdo", "<Cmd>diffoff<cr>", desc = "Diff Off", group = "Diff"},
        {"<leader>tdt", "<Cmd>diffthis<cr>", desc = "Diff On", group = "Diff"},
        {"<leader>tl", "<Cmd>setlocal list! list? <CR>", desc = "Toggle 'list'", group = "Toggle"},
        {"<leader>tnn", "<Cmd>setlocal number! number? <CR>", desc = "Toggle 'number'", group = "Number"},
        {
            "<leader>tnr",
            "<Cmd>setlocal relativenumber! relativenumber? <CR>",
            desc = "Toggle 'relativenumber",
            group = "Number"
        },
        {"<leader>tr", "<Cmd>setlocal ruler! ruler?<CR>", desc = "Toggle 'ruler'", group = "Toggle"},
        {
            "<leader>ts",
            "<Cmd>setlocal spell! spelllang=en_us | setlocal spell? <CR> ",
            desc = "Toggle 'spell'",
            group = "Toggle"
        },
        {
            "<leader>tv",
            ':<C-U>set <C-R>=(&virtualedit =~# "all") ? "virtualedit-=all" : "virtualedit+=all"<CR> virtualedit?<CR>',
            desc = "Toggle 'virtualedit'",
            group = "Toggle"
        }
    }
)

-- vim:foldmethod=marker foldlevel=0
