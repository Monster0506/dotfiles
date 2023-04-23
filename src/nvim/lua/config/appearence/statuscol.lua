local builtin = require("statuscol.builtin")
require("statuscol").setup(
    {
        segments = {
            {
                text = {
                    '%= %#foldcolumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1)? (foldclosed(v:lnum) == -1? "":  ""): " "}%= '
                },
                auto = true,
                maxwidth = 1,
                click = "v:lua.ScFa",
                condition = {true}
            },
            {
                text = {" " .. "%s"},
                click = "v:lua.ScSa",
                maxwidth = 2,
                auto = false,
                colwidth = 4,
                condition = {
                    true,
                    builtin.not_empty
                }
            },
            {
                text = {" ", builtin.lnumfunc, " "},
                condition = {true, builtin.not_empty},
                click = "v:lua.ScLa"
            }
        }
    }
)

-- vim:foldmethod=marker foldlevel=0
