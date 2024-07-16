local wk = require("which-key")
wk.add(
    {
        {"<space>r", "<Cmd>FloatermNew ranger<CR>", desc = "Ranger"},
        {"<space>t", "<Cmd>FloatermToggle<CR>", desc = "New Terminal"}
    }
)
wk.add(
    {
        {"<space>t", "<Cmd>FloatermNew<CR>", desc = "New Terminal", mode = "x"}
    }
)

-- vim:foldmethod=marker foldlevel=0
