local M = {}
function M.run()
    require("gitsigns").setup(
        {
            current_line_blame = true
        }
    )

    require("onedark").setup(
        {
            style = "darker"
        }
    )

    require("crates").setup(
        {
            src = {
                coq = {
                    enabled = true,
                    name = "crates.nvim"
                }
            }
        }
    )

    require("coq_3p")(
        {
            {src = "nvimlua"},
            {src = "bc", short_name = "MATH", precision = 6},
            {src = "figlet"}
        }
    )

    require("nvim-lightbulb").setup(
        {
            autocmd = {
                enabled = true
            },
            sign = {
                enabled = true
            }
        }
    )

    require("nvim-tree").setup(
        {
            view = {
                side = "right",
                mappings = {
                    list = {
                        {key = "<C-t>", action = "close"}
                    }
                }
            },
            filters = {
                dotfiles = false
            }
        }
    )

    require("icon-picker")
    require("leap")
    require("onedark").load()
    require("nvim-lsp-installer").setup()
    require("nvim-autopairs").setup()
end

return M
