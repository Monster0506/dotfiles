-- "" to insert docstring {{{
local wk = require("which-key")

wk.register(
    {
        ['"'] = {'o""""""<esc>2hi', "Insert Docstring"}
    },
    {prefix = '"'}
)
-- }}}
-- vim:foldmethod=marker foldlevel=0
