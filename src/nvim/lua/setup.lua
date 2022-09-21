#!/usr/bin/env lua

local M = {}
function M.run() -- {{{
    require("gitsigns").setup(
        {
            -- {{{
            current_line_blame = true
         -- }}}
        }
    )

    require("Comment").setup()

    require("onedark").setup(
        {
            -- {{{
            style = "darker"
         -- }}}
        }
    )

    require("crates").setup()

    require("nvim-lightbulb").setup(
        {
            -- {{{
            autocmd = {
                -- {{{
                enabled = true
             -- }}}
            },
            sign = {
                -- {{{
                enabled = true
             -- }}}
            }
         -- }}}
        }
    )

    require("nvim-tree").setup(
        {
            -- {{{
            view = {
                -- {{{
                side = "right",
                mappings = {
                    -- {{{
                    list = {
                        -- {{{
                        {key = "<C-t>", action = "close"},
                        {key = "u", action = "dir_up"}
                     -- }}}
                    }
                 -- }}}
                }
             -- }}}
            },
            filters = {
                -- {{{
                dotfiles = false,
                custom = {"^.git$"}
             -- }}}
            }
         -- }}}
        }
    )

    require("mason").setup(
        {
            -- {{{
            ui = {
                -- {{{
                icons = {
                    -- {{{
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                 -- }}}
                }
             -- }}}
            }
         -- }}}
        }
    )

    require("icon-picker")
    require("leap")
    require("onedark").load()
    require("nvim-autopairs").setup()
    local handler = function(virtText, lnum, endLnum, width, truncate) -- {{{
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do -- {{{
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then -- {{{
                table.insert(newVirtText, chunk)
             -- }}}
            else -- {{{
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, {chunkText, hlGroup})
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then -- {{{
                    suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                 -- }}}
                end
                break
             -- }}}
            end
            curWidth = curWidth + chunkWidth
         -- }}}
        end
        table.insert(newVirtText, {suffix, "MoreMsg"})
        return newVirtText
     -- }}}
    end

    -- global handler
    require("ufo").setup(
        {
            -- {{{
            fold_virt_text_handler = handler
         -- }}}
        }
    )

    -- buffer scope handler
    -- will override global handler if it is existed
    local bufnr = vim.api.nvim_get_current_buf()
    require("ufo").setFoldVirtTextHandler(bufnr, handler)
 -- }}}
end

return M
