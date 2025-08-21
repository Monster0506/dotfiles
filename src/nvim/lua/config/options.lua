vim.diagnostic.config({ signs = true, virtual_lines = false, underline = { current_line = true } })
opt = vim.o

local function foldtext()
	return vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1]
end

local function foldexpr()
	local buf = vim.api.nvim_get_current_buf()
	if vim.b[buf].ts_folds == nil then
		if vim.bo[buf].filetype == "" then
			return "0"
		end
		if vim.bo[buf].filetype:find("dashboard") then
			vim.b[buf].ts_folds = false
		else
			vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
		end
	end
	return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

if vim.g.neovide then
	opt.guifont = "FiraCode Nerd Font Mono:h14:w1"

	opt.termguicolors = true
	vim.g.neovide_cursor_animation_length = 0.150
	vim.g.neovide_cursor_trail_size = 0.15
	vim.g.neovide_scale_factor = 1.0
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.05)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.05)
	end)
end

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.conceallevel = 2
opt.cursorline = true
opt.expandtab = true
opt.inccommand = "nosplit"
opt.list = true
opt.number = true
opt.relativenumber = true
opt.shiftround = true
opt.shiftwidth = 4
opt.signcolumn = "yes"
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 4
opt.virtualedit = "block"
opt.foldlevel = 99
opt.formatexpr = 'v:lua.require("conform").formatexpr()'
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.smoothscroll = true
opt.foldexpr = foldexpr()
opt.foldmethod = "expr"
opt.foldtext = ""
opt.shell = "powershell"
opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
