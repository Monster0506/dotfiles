return {

	{
		-- "MeanderingProgrammer/render-markdown.nvim",
	},

	{
		"OXY2DEV/markview.nvim",
	},
	{
		"xzbdmw/colorful-menu.nvim",
		opts = {},
	},
	{
		"ficcdaf/ashen.nvim",
		name = "ashen",
		priority = 1000,
	},
	{
		"MagicDuck/grug-far.nvim",
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "|" },
				change = { text = "|" },
				delete = { text = "_" },
				topdelete = { text = "-" },
				changedelete = { text = "~" },
				untracked = { text = "?" },
			},
			signs_staged = {
				add = { text = "|" },
				change = { text = "|" },
				delete = { text = ">" },
				topdelete = { text = ">" },
				changedelete = { text = "|" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				-- stylua: ignore start
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
				map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
				map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
				natural_order = true,
				is_always_hidden = function(name, _)
					return name == ".." or name == ".git"
				end,
			},
			float = {
				padding = 2,
				max_width = 90,
				max_height = 0,
			},
			win_options = {
				wrap = true,
				winblend = 0,
			},
			keymaps = {
				["<BS>"] = "actions.parent",
				gs = {
					callback = function()
						local oil = require("oil")
						local prefills = { paths = oil.get_current_dir() }
						local grug_far = require("grug-far")
						if not grug_far.has_instance("explorer") then
							grug_far.open({
								instanceName = "explorer",
								prefills = prefills,
								staticTitle = "Find and Replace from Explorer",
							})
						else
							grug_far.get_instance("explorer"):open()
							grug_far.get_instance("explorer"):update_input_values(prefills, false)
						end
					end,
					desc = "oil: Search in directory",
				},
			},
		},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		lazy = false,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "goimports", "gofmt" },
				cpp = { "clang-format" },
				hpp = { "clang-format" },
			},
			formatters = {
				isort = {
					args = {
						"--lines-after-import",
						"2",
						"--quiet",
						"-",
					},
				},
				["clang-format"] = {
					args = {
						"-style={BasedOnStyle: google, IndentWidth: 4}",
						"-",
					},
				},
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
		},

		config = function()
			local lsp_config_data = require("config.plugins.lspconfig")

			local capabilities = lsp_config_data.capabilities
			local on_attach_common = lsp_config_data.on_attach_common
			local server_opts_data = lsp_config_data.opts.servers

			-- Setup all normal servers
			for server, server_opts in pairs(server_opts_data) do
				server_opts.capabilities =
					vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
				server_opts.on_attach = on_attach_common
				vim.lsp.config(server, server_opts)
			end
			vim.lsp.enable(vim.tbl_keys(server_opts_data))

			-- Special setup for emmet_language_server
			vim.lsp.config("emmet_language_server", {
				filetypes = {
					"eruby",
					"html",
					"javascript",
					"less",
					"sass",
					"scss",
					"pug",
				},
				init_options = {
					---@type table<string, string>
					includeLanguages = {},
					---@type string[]
					excludeLanguages = { "tsx", "jsx" },
					---@type string[]
					extensionsPath = {},
					---@type table<string, any>
					preferences = {},
					---@type boolean Defaults to `true`
					showAbbreviationSuggestions = true,
					---@type "always" | "never"
					showExpandedAbbreviation = "always",
					---@type boolean Defaults to `false`
					showSuggestionsAsSnippets = false,
					---@type table<string, any>
					syntaxProfiles = {},
					---@type table<string, string>
					variables = {},
				},
				capabilities = capabilities,
				on_attach = on_attach_common,
			})
			vim.lsp.enable("emmet_language_server")
		end,
	},
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "1.*",
		opts = {
			enabled = function(ftype)
				return true
			end,
			sources = {
				default = function()
					if vim.bo.filetype == "markdown" then
						return { "path", "snippets", "buffer" }
					elseif vim.bo.filetype == "lua" then
						return { "path", "snippets", "buffer" }
					else
						return { "lsp", "path", "snippets", "buffer" }
					end
				end,
			},
			cmdline = { enabled = false },
			keymap = { preset = "super-tab" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			completion = {
				list = { selection = { preselect = false, auto_insert = true } },

				keyword = { range = "full" },

				accept = { auto_brackets = { enabled = false } },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},

				ghost_text = {
					enabled = true,
				},
				menu = {
					border = "rounded",
					draw = {
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
			},
			snippets = { preset = "default" },
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"pyright",
				"clangd",
				"lua-language-server",
				"gopls",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
			local function ensure_installed_mason_packages()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed_mason_packages)
			else
				ensure_installed_mason_packages()
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"Dan7h3x/signup.nvim",
		opts = {},
	},
	{
		"SmiteshP/nvim-navic",
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"echasnovski/mini.clue",
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			automatic_installation = false,
			automatic_setup = false,
			automatic_enable = false,
			handlers = nil,
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			-- lsp_keymaps = false,
			-- other options
		},
		config = function(lp, opts)
			require("go").setup(opts)
			local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimports()
				end,
				group = format_sync_grp,
			})
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"harenome/vim-mipssyntax",
	},
	{
		"eero-lehtinen/oklch-color-picker.nvim",
		event = "VeryLazy",
		version = "*",
		keys = {
			{
				"<leader>v",
				function()
					require("oklch-color-picker").pick_under_cursor()
				end,
				desc = "Color pick under cursor",
			},
		},
		---@type oklch.Opts
		opts = {},
	},
	{ "wakatime/vim-wakatime", lazy = false },
}
