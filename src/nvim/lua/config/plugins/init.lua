require("config.plugins.treesitter")
require("config.plugins.telescope")
require("config.plugins.miniclue")
require("config.plugins.codecompanion")
require("config.plugins.tjlang").setup()
require("config.plugins.runner").setup({
	runners = {
		asm = {
			run = "java -jar C:\\Users\\TJ\\.vscode\\extensions\\ahmz1833.mars-mips-1.0.4\\mars.jar nc me %file%",
			filetypes = { "asm", "mars", "mips" },
			run_command = "MarsRun",
		},
		python = {
			run = "python %file%",
			filetypes = { "python" },
			run_command = "PyRun",
		},
		lua = {
			run = "lua %file%",
			filetypes = { "lua" },
		},
	},
})
