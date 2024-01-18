local wk = require("which-key")
opts = {silent = true, noremap = true}

wk.register(
    {
        {name = "Annotations"},
        a = {"<CMD>lua require('neogen').generate()<CR>", "Generate Annotation", opts},
        c = {"<CMD>lua require('neogen').generate({type='class'})<CR>", "Class Annotation", opts},
        d = {"<CMD>lua require('neogen').generate({type='file'})<CR>", "Document Annotation", opts},
        f = {"<CMD>lua require('neogen').generate({type='function'})<CR>", "Function Annotation", opts},
        t = {"<CMD>lua require('neogen').generate({type='type'})<CR>", "Type Annotation", opts}
    },
    {prefix = "<leader>a"}
)
