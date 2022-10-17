local wk = require("which-key")
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
