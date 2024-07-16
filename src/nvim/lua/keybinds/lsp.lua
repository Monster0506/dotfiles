local wk = require("which-key")
wk.add(
    {
        -- LSP Mappings {{{
        {"[g", vim.diagnostic.go, desc = "Previous Diagnostic"},
        {"]g", vim.diagnostic.goto_next, desc = "Next Diagnostic"}
    }
)
wk.add(
    {
        {"<leader>e", vim.diagnostic.open_float, desc = "View Float"},
        {"<leader>e", vim.diagnostic.setloclist, desc = "View Diagnostics"}
    }
)
--- }}}

-- vim:foldmethod=marker foldlevel=0
