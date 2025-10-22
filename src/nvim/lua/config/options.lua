local opt = vim.o
local g = vim.g

if g.neovide then
	opt.guifont = "FiraCode Nerd Font Mono:h14:w1"
	opt.termguicolors = true

	g.neovide_cursor_animation_length = 0.15
	g.neovide_cursor_trail_size = 0.05
	g.neovide_scale_factor = 1.0

	local change_scale_factor = function(delta)
		g.neovide_scale_factor = g.neovide_scale_factor * delta
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
opt.formatexpr = 'v:lua.require("conform").formatexpr()'
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.smoothscroll = true

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

vim.fn.sign_define("FoldedIconOpen", { text = "- ", texthl = "FoldColumn" }) -- down arrow
vim.fn.sign_define("FoldedIconClosed", { text = "+ ", texthl = "FoldColumn" }) -- right arrow

opt.fillchars = table.concat({
	"eob:~",
	"foldopen:-",
	"foldclose:+",
	"foldsep:|",
	"fold: ",
}, ",")

if vim.fn.has("win32") == 1 then
	opt.shell = "pwsh"
	opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
	opt.shellquote = ""
	opt.shellxquote = ""
else
	opt.shell = "bash"
end

opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.diagnostic.config({
	signs = true,
	virtual_lines = false,
	underline = { current_line = true },
})
