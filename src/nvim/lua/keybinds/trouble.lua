local wk = require("which-key")

wk.register(
    {
        x = {
            "<cmd>TroubleToggl<CR>",
            "Toggle Trouble"
        },
        w = {
            "<cmd>Trouble lsp_workspace_diagnostics<CR>",
            "Workspace Diagnostics"
        },
        d = {
            "<cmd>Trouble document_diagnostics<CR>",
            "Document Diagnostics"
        },
        l = {
            "<cmd>Trouble loclist<CR>",
            "Location List"
        },
        q = {
            "<cmd>Trouble quickfix<CR>",
            "Quickfix"
        },
        r = {
            "<cmd>Trouble lsp_references<CR>",
            "References"
        }
    },
    {prefix = "<leader>x", name = "Trouble"}
)

-- vim:foldmethod=marker foldlevel=0
