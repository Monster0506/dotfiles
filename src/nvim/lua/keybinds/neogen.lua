local wk = require("which-key")
opts = {silent = true, noremap = true}

wk.add(
    {
        {"<leader>aa", "<CMD>lua require('neogen').generate()<CR>", desc = "Generate Annotation"},
        {"<leader>ac", "<CMD>lua require('neogen').generate({type='class'})<CR>", desc = "Class Annotation"},
        {"<leader>ad", "<CMD>lua require('neogen').generate({type='file'})<CR>", desc = "Document Annotation"},
        {"<leader>af", "<CMD>lua require('neogen').generate({type='function'})<CR>", desc = "Function Annotation"},
        {"<leader>at", "<CMD>lua require('neogen').generate({type='type'})<CR>", desc = "Type Annotation"}
    }
)
