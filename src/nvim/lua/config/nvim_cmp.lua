local cmp = require "cmp"
local luasnip = require "luasnip"

local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
cmp.setup.filetype(
    "lua",
    {
        sources = cmp.config.sources(
            {
                {name = "nvim_lua"},
                {name = "buffer"},
                {name = "path"},
                {name = "calc"},
                {name = "ultisnips"}
            }
        )
    }
)
cmp.setup(
    {
        window = {
            completion = {
                winhighlight = "Normal:Pmen,FloatBorder:Pmenu,Search:None"
            }
        },
        formatting = {
            fields = {"kind", "abbr", "menu"},
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format("%s %s", require("utils.codicons")[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                -- Source
                vim_item.menu =
                    ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[LaTeX]",
                    calc = "[Calc]"
                })[entry.source.name]
                return vim_item
            end
        },
        view = {
            entries = {name = "custom", selection_order = "near_cursor"}
        },
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                -- { name = 'luasnip' }, -- For luasnip users.
            end
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
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
                {name = "nvim_lsp"},
                -- {name = "ultisnips"},
                {name = "luasnip"}
            },
            {
                {name = "buffer"},
                {name = "path"},
                {name = "calc"}
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
                        cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end,
                {
                    "i",
                    "s"
                }
            )
        }
    }
)

cmp.setup(
    {
        enabled = function()
            -- disable completion in comments
            local context = require "cmp.config.context"
            -- keep command mode completion enabled when cursor is in a comment
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
        view = {
            entries = {name = "wildmenu", separator = " | "}
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            {name = "buffer"}
        }
    }
)

cmp.setup.cmdline(
    ":",
    {
        view = {
            entries = {name = "custom", selection_order = "near_cursor"}
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)
