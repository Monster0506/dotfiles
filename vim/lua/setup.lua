local M = {}
function M.run()
    require("nvim-lsp-installer").setup()
    require("gitsigns").setup(
        {
            current_line_blame = true
        }
    )
    require("onedark").load()
    require("onedark").setup(
        {
            style = "darker"
        }
    )
    require("nvim-autopairs").setup()
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
end
return M
