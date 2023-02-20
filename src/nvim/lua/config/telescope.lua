require("telescope").setup(
    {
        extensions = {
            undo = {side_by_side = false}
        }
    }
)
require("telescope").load_extension("undo")
