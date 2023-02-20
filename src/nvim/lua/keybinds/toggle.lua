local wk = require("which-key")

wk.register(
    {
        v = {
            ':<C-U>set <C-R>=(&virtualedit =~# "all") ? "virtualedit-=all" : "virtualedit+=all"<CR> virtualedit?<CR>',
            "Toggle 'virtualedit'"
        },
        s = {"<Cmd>setlocal spell! spelllang=en_us | setlocal spell? <CR> ", "Toggle Spell"},
        l = {"<Cmd>setlocal list! list? <CR>", "Toggle 'list'"},
        b = {'<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"; print(vim.o.bg)<CR>', "Toggle 'background'"},
        n = {
            name = "Number",
            n = {"<Cmd>setlocal number! number? <CR>", "Toggle 'number'"},
            r = {"<Cmd>setlocal relativenumber! relativenumber? <CR>", "Toggle 'relativenumber"}
        },
        c = {
            name = "Cursor",
            c = {
                "<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>",
                "Toggle 'cursorcolumn'"
            },
            l = {
                "<Cmd>setlocal cursorline! cursorline?<CR>",
                "Toggle 'cursorline'"
            }
        },
        r = {"<Cmd>setlocal ruler! ruler?<CR>", "Toggle 'ruler'"},
        d = {
            name = "Diff",
            t = {"<Cmd>diffthis<cr>", "Diff On"},
            o = {"<Cmd>diffoff<cr>", "Diff Off"}
        }
    },
    {
        prefix = "<leader>t",
        name = "toggle/tag"
    }
)
