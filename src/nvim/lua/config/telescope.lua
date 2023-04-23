local trouble = require("trouble.providers.telescope")
local actions = require("telescope.actions")
require("telescope").setup(
    {
        extensions = {
            undo = {side_by_side = false}
        },
        defaults = {
            mappings = {
                i = {
                    ["<C-t>"] = trouble.open_with_trouble,
                    ["<esc>"] = actions.close
                },
                n = {
                    ["<C-t>"] = trouble.open_with_trouble
                }
            }
        }
    }
)
require("telescope").load_extension("undo")

-- vim:foldmethod=marker foldlevel=0
