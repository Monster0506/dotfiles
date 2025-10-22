return {
	{
		"ficcdaf/ashen.nvim",
		name = "ashen",
		priority = 1000,
	},
	{
		"OXY2DEV/markview.nvim",
	},
	{
		"xzbdmw/colorful-menu.nvim",
		opts = {},
	},

	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
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
			float = { padding = 2, max_width = 90, max_height = 0 },
			win_options = { wrap = true, winblend = 0 },
			keymaps = {
				["<BS>"] = "actions.parent",
				gs = {
					desc = "Search in directory",
					callback = function()
						local oil = require("oil")
						local grug_far = require("grug-far")
						local prefills = { paths = oil.get_current_dir() }

						if not grug_far.has_instance("explorer") then
							grug_far.open({
								instanceName = "explorer",
								prefills = prefills,
								staticTitle = "Find and Replace from Explorer",
							})
						else
							local inst = grug_far.get_instance("explorer")
							inst:open()
							inst:update_input_values(prefills, false)
						end
					end,
				},
			},
		},
	},

	{ "MagicDuck/grug-far.nvim" },
	{ "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
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
			on_attach = function(buf)
				local gs = package.loaded.gitsigns
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
				end
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

				map("n", "]H", function()
					gs.nav_hunk("last")
				end, "Last Hunk")
				map("n", "[H", function()
					gs.nav_hunk("first")
				end, "First Hunk")

				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Inline")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>ghB", function()
					gs.blame()
				end, "Blame Buffer")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
			end,
		},
	},
	{ "tpope/vim-fugitive" },

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local lsp_config_data = require("config.plugins.lspconfig")
			local capabilities = lsp_config_data.capabilities
			local on_attach_common = lsp_config_data.on_attach_common
			local servers = lsp_config_data.opts.servers

			for name, opts in pairs(servers) do
				opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
				opts.on_attach = on_attach_common
				vim.lsp.config(name, opts)
			end
			vim.lsp.enable(vim.tbl_keys(servers))

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
					includeLanguages = {},
					excludeLanguages = { "tsx", "jsx" },
					showAbbreviationSuggestions = true,
					showExpandedAbbreviation = "always",
					showSuggestionsAsSnippets = false,
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
		version = "1.*",
		dependencies = "rafamadriz/friendly-snippets",
		opts = {
			enabled = function()
				return true
			end,
			keymap = { preset = "super-tab" },
			cmdline = { enabled = false },
			sources = {
				default = function()
					local ft = vim.bo.filetype
					if ft == "markdown" or ft == "lua" then
						return { "path", "snippets", "buffer" }
					end
					return { "lsp", "path", "snippets", "buffer" }
				end,
			},
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
				ghost_text = { enabled = true },
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
			signature = { enabled = true, window = { border = "rounded" } },
		},
		opts_extend = { "sources.default" },
	},

	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")

			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local pkg = mr.get_package(tool)
					if not pkg:is_installed() then
						pkg:install()
					end
				end
			end

			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end

			mr:on("package:install:success", function()
				vim.defer_fn(function()
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
		end,
		opts = {
			ensure_installed = { "pyright", "clangd", "lua-language-server", "gopls" },
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_installation = false,
			automatic_setup = false,
			automatic_enable = false,
			handlers = nil,
		},
	},

	{
		"ray-x/go.nvim",
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function(_, opts)
			require("go").setup(opts)
			local group = vim.api.nvim_create_augroup("GoFormat", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimports()
				end,
				group = group,
			})
		end,
	},

	{
		"Monster0506/universal_runner.nvim",
		opts = {
			runners = {
				asm = {
					run = "java -jar C:\\Users\\TJ\\.vscode\\extensions\\ahmz1833.mars-mips-1.0.4\\mars.jar nc me %file%",
					filetypes = { "asm", "mars", "mips" },
					run_command = "MarsRun",
				},
				python = {
					run = "uv run %file%",
					filetypes = { "python" },
				},
			},
		},
	},

	{ "harenome/vim-mipssyntax" },

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
				isort = { args = { "--lines-after-import", "2", "--quiet", "-" } },
				["clang-format"] = {
					args = { "-style={BasedOnStyle: google, IndentWidth: 4}", "-" },
				},
			},
		},
	},

	{ "echasnovski/mini.clue" },
	{ "SmiteshP/nvim-navic" },
	{ "Dan7h3x/signup.nvim", opts = {} },
	{ "olimorris/codecompanion.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
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
		opts = {},
	},
	{ "wakatime/vim-wakatime", lazy = false },
}
