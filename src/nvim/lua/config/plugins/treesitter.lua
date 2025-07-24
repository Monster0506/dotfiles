require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
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
