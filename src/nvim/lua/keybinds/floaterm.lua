local wk = require("which-key")
wk.register(
    {
        t = {"<Cmd>FloatermToggle<CR>", "New Terminal"},
        r = {"<Cmd>FloatermNew ranger<CR>", "Ranger"},
        u = {"<Cmd>MundoToggle<CR>", "Undo Menu"}
    },
    {prefix = "<space>"}
)
wk.register(
    {
        t = {"<Cmd>FloatermNew<CR>", "New Terminal"}
    },
    {prefix = "<space>", mode = "x"}
)
