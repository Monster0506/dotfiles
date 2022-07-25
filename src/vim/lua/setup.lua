#!/usr/bin/env lua

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

    require("crates").setup()

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
                        {key = "<C-t>", action = "close"},
                        {key = "u", action = "dir_up"}
                    }
                }
            },
            filters = {
                dotfiles = false,
                custom = {"^.git$"}
            }
        }
    )

    require("mason").setup(
        {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    )

    require("icon-picker")
    require("leap")
    require("onedark").load()
    require("nvim-autopairs").setup()
end

return M
