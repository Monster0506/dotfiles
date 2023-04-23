local cmp = require "cmp"
local luasnip = require "luasnip"

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
cmp.setup.filetype(
    "lua",
    {
        sources = cmp.config.sources(
            {
                {name = "nvim_lua"},
                {name = "rg"},
                {name = "buffer"},
                {name = "calc"},
                {name = "async_path"},
                {name = "git"},
                {name = "luasnip"}
            }
        )
    }
)

cmp.setup(
    {
        completion = {completeopt = "menu,menuone,noinsert"},
        window = {
            completion = {
                border = "rounded",
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                scrollbar = "║"
            },
            documentation = {
                -- no border; native-style scrollbar
                border = nil,
                scrollbar = ""
                -- other options
            }
        },
        formatting = {
            fields = {"kind", "abbr", "menu"},
            format = function(entry, vim_item)
                local icon = string.format("%s %s", require("utils.codicons")[vim_item.kind], vim_item.kind)
                vim_item.kind = " " .. (icon or "") .. " "
                local menu =
                    ({
                    buffer = "Buffer",
                    nvim_lsp = "LSP",
                    git = "Git",
                    rg = "Rg",
                    luasnip = "LuaSnip",
                    nvim_lua = "Lua",
                    latex_symbols = "LaTeX",
                    calc = "Calc"
                })[entry.source.name]
                vim_item.menu = "    [" .. (menu or "") .. "]"
                return vim_item
            end
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm(
                    {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }
                )
            }
        ),
        sources = cmp.config.sources(
            {
                {name = "luasnip"},
                {name = "git"},
                {name = "nvim_lsp"},
                {name = "buffer"},
                {name = "async_path"},
                {name = "calc"},
                {name = "rg"}
            }
        )
    }
)

cmp.setup(
    {
        enabled = function()
            local context = require "cmp.config.context"
            if vim.api.nvim_get_mode().mode == "c" then
                return true
            else
                return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
            end
        end
    }
)

cmp.setup.cmdline(
    "/",
    {
        completion = {completeopt = "menuone"},
        view = {
            entries = {name = "custom", selection_order = "near_cursor"}
        },
        sources = cmp.config.sources(
            {
                {name = "buffer"},
                {name = "rg"}
            }
        ),
        mapping = cmp.mapping.preset.cmdline()
    }
)

cmp.setup.cmdline(
    ":",
    {
        completion = {completeopt = "menuone"},
        view = {
            entries = {name = "wildmenu", separator = " | "}
            -- entries = {name = "custom"}
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            {
                {name = "async_path"},
                {name = "cmdline"}
            }
        )
    }
)

cmp.setup(
    {
        mapping = {
            ["<Tab>"] = cmp.mapping(
                function(fallback)
                    if require("copilot.suggestion").is_visible() then
                        require("copilot.suggestion").accept()
                    elseif cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
                        else
                            cmp.confirm({select = true})
                        end
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end,
                {
                    "i",
                    "s",
                    "c"
                }
            )
        }
    }
)

require("cmp_git").setup()

-- vim:foldmethod=marker foldlevel=0
