local map = vim.keymap.set
if vim.fn.has("gui_running") == 1 or vim.g.neovide then
	map({ "c", "i" }, "<RightMouse>", '<C-r>"')
end

local function variants(str)
	local results = {}

	local function helper(prefix, rest)
		if #rest == 0 then
			table.insert(results, prefix)
		else
			local first = rest:sub(1, 1)
			local rest_sub = rest:sub(2)
			helper(prefix .. first:lower(), rest_sub)
			helper(prefix .. first:upper(), rest_sub)
		end
	end

	local first_char = str:sub(1, 1):upper()
	local rest = str:sub(2)

	helper(first_char, rest)

	return results
end

local function create_cmd_variants(name, fn, opts)
	for _, variant in ipairs(variants(name)) do
		vim.api.nvim_create_user_command(variant, fn, opts)
	end
end

create_cmd_variants("w", function(opts)
	if opts.bang then
		vim.cmd("write!")
	else
		vim.cmd("write")
	end
end, { desc = "Write", bang = true })

create_cmd_variants("naw", function(opts)
	if opts.bang then
		vim.cmd("noau write!")
	else
		vim.cmd("noau write")
	end
end, { desc = "Write without autocommands", bang = true })

create_cmd_variants("wq", function(opts)
	if opts.bang then
		vim.cmd("wq!")
	else
		vim.cmd("wq")
	end
end, { desc = "Write and quit", bang = true })

create_cmd_variants("nwq", function(opts)
	if opts.bang then
		vim.cmd("noau wq!")
	else
		vim.cmd("noau wq")
	end
end, { desc = "Write and quit without autocommands", bang = true })

create_cmd_variants("wa", function(opts)
	if opts.bang then
		vim.cmd("wall!")
	else
		vim.cmd("wall")
	end
end, { desc = "Write all buffers", bang = true })

create_cmd_variants("nwa", function(opts)
	if opts.bang then
		vim.cmd("noau wall!")
	else
		vim.cmd("noau wall")
	end
end, { desc = "Write all buffers without autocommands", bang = true })

create_cmd_variants("wqa", function(opts)
	if opts.bang then
		vim.cmd("wqa!")
	else
		vim.cmd("wqa")
	end
end, { desc = "Write all buffers and quit", bang = true })

create_cmd_variants("nwqa", function(opts)
	if opts.bang then
		vim.cmd("noau wqa!")
	else
		vim.cmd("noau wqa")
	end
end, { desc = "Write all buffers and quit without autocommands", bang = true })

create_cmd_variants("q", function(opts)
	if opts.bang then
		vim.cmd("noau q!")
	else
		vim.cmd("noau q")
	end
end, { desc = "Write all buffers and quit without autocommands", bang = true })

map("n", "<leader>e", function()
	require("oil").toggle_float()
end, { desc = "Explore Files" })

map("n", "<leader>E", function()
	require("oil").toggle_float()
end, { desc = "Explore Files" })
-- Telescope bindings
local telescope = require("telescope.builtin")
map("n", "<leader>sg", telescope.live_grep, { desc = "Grep all files" })
map("n", "<leader>ss", telescope.grep_string, { desc = "Grep under cursor" })
map("n", "<leader>sb", telescope.buffers, { desc = "Explore Buffers" })
map("n", "<leader>sR", telescope.registers, { desc = "Explore Registers" })
map("n", "<leader><space>", telescope.find_files, { desc = "Explore Files" })
map("n", "<leader>d", telescope.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>so", telescope.lsp_outgoing_calls, { desc = "Outgoing Calls" })
map("n", "<leader>si", telescope.lsp_incoming_calls, { desc = "Incoming Calls" })

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

map({ "n", "x" }, "j", "v:count == 0 ? 'gjzz' : 'jzz'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gkzz' : 'kzz'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "G", "Gzz", { desc = "Bottom", silent = true })
map({ "n", "x" }, "gg", "ggzz", { desc = "Top", silent = true })
map({ "n", "x" }, "<C-d>", "<C-d>zz", { desc = "Down", silent = true })
map({ "n", "x" }, "<C-u>", "<C-u>zz", { desc = "Up", silent = true })

map({ "n", "v" }, "<leader>sr", function()
	local grug = require("grug-far")
	local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
	grug.open({
		transient = true,
		prefills = {
			filesFilter = ext and ext ~= "" and "*." .. ext or nil,
		},
	})
end, { desc = "Search and Replace" })

map({ "t" }, "<Esc><Esc>", "<C-\\><C-n>")
map({ "n" }, "<leader>t", "<cmd>vs | term <CR>")

map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Previous Buffer" })
map("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Previous Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bb", telescope.buffers, { desc = "Explore Buffers" })

local function peek_fold()
	local winid = ufo.peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end

local ufo = require("ufo")
map("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
map("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
map("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds except certain kinds" })
map("n", "zm", ufo.closeFoldsWith, { desc = "Close folds with higher level" })
map("n", "zp", peek_fold, { desc = "Peek folded lines under cursor" })
map("n", "[z", function()
	ufo.goPreviousClosedFold()
	ufo.peekFoldedLinesUnderCursor()
end, { desc = "Previous closed fold and preview" })
map("n", "]z", function()
	ufo.goNextClosedFold()
	ufo.peekFoldedLinesUnderCursor()
end, { desc = "Next closed fold and preview" })

local function is_quickfix_open()
	print("checking")
	for _, winid in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winid), "buftype") == "quickfix" then
			print("true")
			return true
		end
	end
	print("false")
	return false
end

vim.keymap.set("n", "n", function()
	if is_quickfix_open() then
		vim.cmd("cnext")
	else
		vim.cmd("normal! n")
	end
end)

vim.keymap.set("n", "N", function()
	if is_quickfix_open() then
		vim.cmd("cprev")
	else
		vim.cmd("normal! N")
	end
end)
