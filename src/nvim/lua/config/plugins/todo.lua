local M = {}

local ns = vim.api.nvim_create_namespace("todo_highlights")

-----------------------------------------------
-- Utils
-----------------------------------------------
local function today()
	return os.date("%Y-%m-%d")
end

local function compare_date(date)
	-- returns -1 if date < today, 0 if today, 1 if > today
	local y, m, d = date:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)$")
	if not y then
		return nil
	end
	local date_num = os.time({ year = tonumber(y), month = tonumber(m), day = tonumber(d) })
	local today_num = os.time({
		year = tonumber(os.date("%Y")),
		month = tonumber(os.date("%m")),
		day = tonumber(os.date("%d")),
	})
	if date_num < today_num then
		return -1
	end
	if date_num > today_num then
		return 1
	end
	return 0
end

local function find_today()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local t = today()
	for i, line in ipairs(lines) do
		if line:find(t, 1, true) then
			return i
		end
	end
end

-----------------------------------------------
-- Highlight Engine
-----------------------------------------------
local function apply_highlights(bufnr)
	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	local in_section = false
	local relation = nil
	local today_blank = nil
	local today_date = today()

	-------------------------------------------
	-- Scan once for today's split point (blank line before subtasks)
	-------------------------------------------
	do
		local in_today = false
		for i, line in ipairs(lines) do
			if line == today_date then
				in_today = true
			elseif line:match("^%d%d%d%d%-%d%d%-%d%d$") then
				in_today = false
			elseif in_today and line:match("^%s*$") and not today_blank then
				local j = i + 1
				while j <= #lines and lines[j]:match("^%s*$") do
					j = j + 1
				end
				if j <= #lines and not lines[j]:match("^%d%d%d%d%-%d%d%-%d%d$") then
					today_blank = i
				end
			end
		end
	end

	-------------------------------------------
	-- Highlight pass
	-------------------------------------------
	for i, line in ipairs(lines) do
		-- Date header lines
		if line:match("^%d%d%d%d%-%d%d%-%d%d$") then
			vim.api.nvim_buf_add_highlight(bufnr, ns, "TodoDate", i - 1, 0, -1)
			in_section = true
			relation = compare_date(line)

			-- Inside a todo section
		elseif in_section and not line:match("^%s*$") then
			-----------------------------------
			-- Full-line highlight first (so time highlights can overwrite)
			-----------------------------------
			local hl_group
			if relation == -1 then
				hl_group = "TodoDone" -- past
			elseif relation == 1 then
				hl_group = "TodoTask" -- future
			else -- today
				if today_blank and i < today_blank then
					hl_group = "TodoDone"
				else
					hl_group = "TodoTask"
				end
			end
			vim.api.nvim_buf_add_highlight(bufnr, ns, hl_group, i - 1, 0, -1)

			-----------------------------------
			-- Then overlay times within the line
			-----------------------------------
			local pos = 1
			while pos <= #line do
				local s, e

				-- Case 1: with minutes, e.g. "12:30pm"
				s, e = line:find("[%d]?[%d]:%d%d[apAP][mM]", pos)

				-- Case 2: just hour, e.g. "7am", "12pm"
				if not s then
					s, e = line:find("%d%d?[apAP][mM]", pos)
				end

				if not s then
					break
				end

				vim.api.nvim_buf_add_highlight(bufnr, ns, "TodoTime", i - 1, s - 1, e)
				pos = e + 1
			end
		end
	end
end

-----------------------------------------------
-- Agenda Builder
-----------------------------------------------
local function build_agenda(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local today_date = today()

	local agenda_lines = {}
	local agenda_map = {} -- idx → {buf, line}

	-- Detect split in today's section
	local today_blank = nil
	do
		local in_today = false
		for i, line in ipairs(lines) do
			if line == today_date then
				in_today = true
			elseif line:match("^%d%d%d%d%-%d%d%-%d%d$") then
				in_today = false
			elseif in_today and line:match("^%s*$") and not today_blank then
				local j = i + 1
				while j <= #lines and lines[j]:match("^%s*$") do
					j = j + 1
				end
				if j <= #lines and not lines[j]:match("^%d%d%d%d%-%d%d%-%d%d$") then
					today_blank = i
				end
			end
		end
	end

	local current_date, relation
	for i, line in ipairs(lines) do
		if line:match("^%d%d%d%d%-%d%d%-%d%d$") then
			current_date = line
			relation = compare_date(line)
		elseif current_date and line:match("^%s*$") then
			-- skip blanks
		elseif current_date and line:match("%S") then
			if relation == -1 then
				-- past → skip
			elseif relation == 1 then
				-- future → all not done
				table.insert(agenda_lines, current_date .. "  " .. line)
				agenda_map[#agenda_lines] = { bufnr, i }
			else
				-- today
				if today_blank then
					if i > today_blank then
						table.insert(agenda_lines, current_date .. "  " .. line)
						agenda_map[#agenda_lines] = { bufnr, i }
					end
				else
					-- no blank → everything not done
					table.insert(agenda_lines, current_date .. "  " .. line)
					agenda_map[#agenda_lines] = { bufnr, i }
				end
			end
		end
	end

	return agenda_lines, agenda_map
end

-----------------------------------------------
-- Agenda Window
-----------------------------------------------
local function open_agenda_window(agenda_lines, agenda_map)
	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.6)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	if #agenda_lines == 0 then
		agenda_lines = { "No upcoming tasks" }
	end
	table.sort(agenda_lines)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, agenda_lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].bufhidden = "wipe"

	-------------------------------------------
	-- Apply highlights in agenda buffer
	-------------------------------------------
	local ns_agenda = vim.api.nvim_create_namespace("todo_agenda")
	vim.api.nvim_buf_clear_namespace(buf, ns_agenda, 0, -1)

	for i, line in ipairs(agenda_lines) do
		-- skip placeholder
		if line ~= "No upcoming tasks" then
			local date, task = line:match("^(%d%d%d%d%-%d%d%-%d%d)%s+(.*)$")
			if date and task then
				-- date highlight
				vim.api.nvim_buf_add_highlight(buf, ns_agenda, "TodoDate", i - 1, 0, #date)

				-- decide if past/today/future
				local relation = compare_date(date)
				local hl_group
				if relation == -1 then
					hl_group = "TodoDone"
				elseif relation == 1 then
					hl_group = "TodoTask"
				else
					hl_group = "TodoTask" -- all today tasks are active here
				end

				-- apply task highlight
				vim.api.nvim_buf_add_highlight(buf, ns_agenda, hl_group, i - 1, #date + 2, -1)
			end
		end
	end

	-------------------------------------------
	-- Map Enter to jump back
	-------------------------------------------
	vim.keymap.set("n", "<CR>", function()
		local cur = vim.api.nvim_win_get_cursor(0)[1] -- 1-based
		local target = agenda_map[cur]
		if target then
			local target_bufnr, target_line = target[1], target[2]
			vim.api.nvim_win_close(win, true)
			vim.api.nvim_set_current_buf(target_bufnr)
			vim.api.nvim_win_set_cursor(0, { target_line, 0 })
		end
	end, { buffer = buf, nowait = true, noremap = true, silent = true })
end

-------------------------------------------------
-- Default config
-------------------------------------------------
local default_config = {
	highlights = {
		TodoDate = { guifg = "#FFD700", gui = "bold" },
		TodoDone = { guifg = "#888888", gui = "strikethrough" },
		TodoTask = { guifg = "#FFFFFF" },
		TodoTime = { guifg = "#87CEEB", gui = "italic" },
	},
	commands = {
		agenda = { enable = true, name = "TodoAgenda" },
		today = { enable = true, name = "TodoToday" },
		search = { enable = true, name = "TodoSearch" },
	},
	keymaps = {
		agenda = { lhs = "<leader>ra", rhs = ":TodoAgenda<CR>", desc = "Open Agenda" },
		today = { lhs = "<leader>rt", rhs = ":TodoToday<CR>", desc = "Jump to today" },
		search = { lhs = "<leader>rs", rhs = ":TodoSearch ", desc = "Search task" },
	},
	autocmds = {
		enable = true,
		events = { "BufEnter", "TextChanged", "TextChangedI" },
	},
}

-- merged user opts
local config = {}

-------------------------------------------------
-- Helpers
-------------------------------------------------
local function set_highlights()
	for group, opts in pairs(config.highlights) do
		local cmd = ("highlight default %s"):format(group)
		if opts.guifg then
			cmd = cmd .. " guifg=" .. opts.guifg
		end
		if opts.guibg then
			cmd = cmd .. " guibg=" .. opts.guibg
		end
		if opts.gui then
			cmd = cmd .. " gui=" .. opts.gui
		end
		vim.cmd(cmd)
	end
end

-----------------------------------------------
-- Commands
-----------------------------------------------
local function setup_commands()
	if config.commands.agenda.enable then
		vim.api.nvim_create_user_command(config.commands.agenda.name, function()
			local lines, map = build_agenda(0)
			open_agenda_window(lines, map)
		end, {})
	end

	if config.commands.today.enable then
		vim.api.nvim_create_user_command(config.commands.today.name, function()
			local ln = find_today()
			if ln then
				vim.api.nvim_win_set_cursor(0, { ln, 0 })
			else
				print("No todos for today!")
			end
		end, {})
	end

	if config.commands.search.enable then
		vim.api.nvim_create_user_command(config.commands.search.name, function(opts)
			if opts.args == "" then
				print("Usage: :" .. config.commands.search.name .. " keyword")
				return
			end
			vim.cmd("vimgrep /" .. opts.args .. "/j %")
			vim.cmd("copen")
		end, { nargs = 1 })
	end
end

local function setup_keymaps()
	for _, keymap in pairs(config.keymaps) do
		if keymap.lhs and keymap.rhs then
			vim.keymap.set("n", keymap.lhs, keymap.rhs, { desc = keymap.desc or "" })
		end
	end
end

local function setup_autocmds()
	if config.autocmds.enable then
		vim.api.nvim_create_autocmd(config.autocmds.events, {
			callback = function(args)
				apply_highlights(args.buf)
			end,
		})
	end
end

-------------------------------------------------
-- Setup
-------------------------------------------------
function M.setup(opts)
	config = vim.tbl_deep_extend("force", default_config, opts or {})

	set_highlights()
	setup_commands()
	setup_keymaps()
	setup_autocmds()
end

return M
