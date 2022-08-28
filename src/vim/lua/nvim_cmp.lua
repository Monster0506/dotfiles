local M = {}

function M.setup()
    local cmp = require "cmp"
    cmp.setup.filetype(
        "lua",
        {
            sources = cmp.config.sources(
                {
                    {name = "nvim_lua"},
                    {name = "buffer"},
                    {name = "path"},
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
                    vim_item.kind = string.format("%s %s", require("codicons")[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                    -- Source
                    vim_item.menu =
                        ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[LaTeX]"
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
                    vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end
            },
            mapping = cmp.mapping.preset.insert(
                {
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }
            ),
            sources = cmp.config.sources(
                {
                    {name = "nvim_lsp"},
                    {name = "ultisnips"} -- For ultisnips users.
                },
                {
                    {name = "buffer"},
                    {name = "path"}
                }
            )
        }
    )

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
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

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
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
    vim.api.nvim_create_autocmd(
        "BufRead",
        {
            group = vim.api.nvim_create_augroup("CmpSourceCargo", {clear = true}),
            pattern = "Cargo.toml",
            callback = function()
                cmp.setup.buffer({sources = {{name = "crates"}}})
            end
        }
    )
end

return M
