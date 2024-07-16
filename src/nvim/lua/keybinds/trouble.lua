local wk = require("which-key")

wk.add(
    {
        {"<leader>xd", "<cmd>Trouble document_diagnostics<CR>", desc = "Document Diagnostics", group = "Trouble"},
        {"<leader>xl", "<cmd>Trouble loclist<CR>", desc = "Location List", group = "Trouble"},
        {"<leader>xq", "<cmd>Trouble quickfix<CR>", desc = "Quickfix", group = "Trouble"},
        {"<leader>xr", "<cmd>Trouble lsp_references<CR>", desc = "References", group = "Trouble"},
        {"<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<CR>", desc = "Workspace Diagnostics", group = "Trouble"},
        {"<leader>xx", "<cmd>TroubleToggl<CR>", desc = "Toggle Trouble", group = "Trouble"}
    }
)

-- vim:foldmethod=marker foldlevel=0
