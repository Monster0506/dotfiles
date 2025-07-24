-- lua/config/telescope.lua (or similar)
local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

telescope.setup({
	defaults = {
		-- Appearance
		theme = "center", -- "dropdown", "ivy", "cursor", or "center"
		prompt_prefix = "", -- A nice magnifying glass icon
		selection_caret = "",
		entry_prefix = "",
		initial_mode = "insert", -- Start in insert mode for typing
		sorting_strategy = "descending", -- or "descending"
		layout_strategy = "vertical", -- or "horizontal", "flex", "center"
		layout_config = {
			vertical = {
				width = 0.9,
				height = 0.9,
				preview_height = 0.6,
			},
			horizontal = {
				width = 0.9,
				height = 0.9,
				preview_width = 0.6,
			},
			center = {
				width = 0.7,
				height = 0.7,
				preview_height = 0.6,
			},
		},
		-- 	-- Other defaults
		file_ignore_patterns = { "node_modules", ".git", ".next", "%.log$" }, -- Ignore common files/folders
		path_display = { "smart" }, -- Show relative paths
		winblend = 0, -- No transparency for the popup window
		-- border = "single", -- "single", "double", "rounded", "solid", "none"
		borderchars = { "-", "|", "-", "|", "+", "+", "+", "+" },
		color_devicons = true, -- Enable file type icons (requires nvim-web-devicons)
		set_env = { ["COLORTERM"] = "truecolor" },
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<C-c>"] = actions.close,
			},
			n = {
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["q"] = actions.close,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = false,
		},
		live_grep = {
			only_sort_text = true,
			theme = "dropdown",
		},
		buffers = {
			initial_mode = "normal", -- Start in normal mode for buffer picker
			mappings = {
				i = {
					["<C-d>"] = actions.delete_buffer, -- Delete buffer in insert mode
				},
				n = {
					["dd"] = actions.delete_buffer, -- Delete buffer in normal mode
				},
			},
		},
		jumplist = {
			initial_mode = "normal",
			layout_strategy = "center",
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_file_sorter = true,
			override_generic_sorter = true,
			case_mode = "smart_case", -- "smart_case", "ignore_case", "respect_case"
		},
	},
})
