local wk = require("which-key")
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

-- vim:foldmethod=marker foldlevel=0
