require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	},
	textobjects = {
		-- === SELECT ===
		select = {
			enable = true,
			lookahead = true, -- auto-jump forward like targets.vim
			keymaps = {
				-- Functions
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				-- Classes
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				-- Parameters
				["ap"] = "@parameter.outer",
				["ip"] = "@parameter.inner",
				-- Conditionals
				["ao"] = "@conditional.outer",
				["io"] = "@conditional.inner",
				-- Loops
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				-- Comments
				["a/"] = "@comment.outer",
				["i/"] = "@comment.inner",
			},
		},

		-- === MOVE ===
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				["]p"] = "@parameter.inner",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				["[p"] = "@parameter.inner",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
			},
		},

		-- === SWAP ===
		swap = {
			enable = true,
			swap_next = {
				["<leader>Snp"] = "@parameter.inner", -- swap parameter
				["<leader>Snf"] = "@function.outer", -- swap function
				["<leader>Snc"] = "@class.outer", -- swap class
				["<leader>Sn/"] = "@comment.outer", -- swap comment block
			},
			swap_previous = {
				["<leader>Spp"] = "@parameter.inner",
				["<leader>Spf"] = "@function.outer",
				["<leader>Spc"] = "@class.outer",
				["<leader>Sp/"] = "@comment.outer",
			},
		},

		-- === LSP INTEROP ===
		lsp_interop = {
			enable = true,
			border = "rounded",
			peek_definition_code = {
				["grpf"] = "@function.outer",
				["grpc"] = "@class.outer",
			},
		},
	},

	ensure_installed = {
		"bash",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"tsx",
		"typescript",
		"vim",
		"yaml",
	},
})
