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
                vim_item.kind = string.format("%s %s", require("utils.codicons")[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
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
                ["<Tab>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }
        ),
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "ultisnips"} -- For ultisnips users.,
                -- {name = "neorg"}
            },
            {
                {name = "buffer"},
                {name = "path"}
            }
        )
    }
)

cmp.setup({
    enabled = function()
      -- disable completion in comments
      local context = require 'cmp.config.context'
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
        return not context.in_treesitter_capture("comment") 
          and not context.in_syntax_group("Comment")
      end
    end
})
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

