-- runner.nvim
local M = {}

-----------------------------------------------------
-- Default options
-----------------------------------------------------
local defaults = {
	keymaps = {
		run = "<leader>rr",
		debug = "<leader>rd",
	},
	split_cmd = "vsplit",
	use_quickfix = false,
	enable_makeprg = true,
	runners = {},
}

M.opts = vim.deepcopy(defaults)

-----------------------------------------------------
-- Helpers
-----------------------------------------------------

local function quote_path(path)
	return '"' .. path .. '"'
end

local function detect_shell_type()
	local shell = vim.o.shell:lower()
	if shell:find("powershell") or shell:find("pwsh") then
		return "pwsh"
	else
		return "bash"
	end
end

local function open_split_terminal()
	vim.cmd(M.opts.split_cmd)
	vim.cmd("term")
	vim.cmd("startinsert")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_get_current_buf()
	return win, buf
end

local function send_command_to_terminal(cmd)
	local win, buf = open_split_terminal()
	local job_id = vim.b[buf].terminal_job_id
	if not job_id then
		return
	end

	local shell_type = detect_shell_type()
	local wait_script
	if shell_type == "pwsh" then
		wait_script = [[; Write-Host "`nPress Enter to close..."; [void][System.Console]::ReadLine(); exit]]
	else
		wait_script = [[; echo -e "\nPress Enter to close..."; read _; exit]]
	end

	vim.fn.chansend(job_id, cmd .. wait_script)
	vim.fn.chansend(job_id, "\r")

	vim.api.nvim_create_autocmd("TermClose", {
		buffer = buf,
		once = true,
		callback = function()
			vim.defer_fn(function()
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_close(win, true)
				end
			end, 300)
		end,
	})
end

local function expand_command(cmd)
	local filename = vim.fn.expand("%:p")
	local expanded = cmd:gsub("%%file%%", quote_path(filename))
	return expanded
end

local function set_makeprg(bufnr, cmd)
	local esc_cmd = vim.fn.escape(expand_command(cmd), " \\")
	vim.api.nvim_buf_call(bufnr, function()
		vim.cmd("setlocal makeprg=" .. esc_cmd)
	end)
end

-----------------------------------------------------
-----------------------------------------------------

local function run_runner(runner, mode)
	local template = runner[mode]
	if not template then
		local msg = "No " .. mode .. " command defined for this runner"
		return
	end
	local final_cmd = expand_command(template)
	send_command_to_terminal(final_cmd)
end

-----------------------------------------------------
-- Setup
-----------------------------------------------------

function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", defaults, opts or {})

	for name, runner in pairs(M.opts.runners) do
		if runner.filetypes then
			vim.api.nvim_create_autocmd("FileType", {
				pattern = runner.filetypes,
				callback = function(ev)
					local bufnr = ev.buf

					local keymaps = vim.tbl_deep_extend("force", M.opts.keymaps, runner.keymaps or {})

					if runner.run then
						vim.keymap.set("n", keymaps.run, function()
							run_runner(runner, "run")
						end, { buffer = bufnr, desc = "Run file" })
					end

					if runner.debug then
						vim.keymap.set("n", keymaps.debug, function()
							run_runner(runner, "debug")
						end, { buffer = bufnr, desc = "Debug file" })
					end

					if runner.run_command then
						vim.api.nvim_buf_create_user_command(bufnr, runner.run_command, function()
							run_runner(runner, "run")
						end, { desc = "Run with " .. name .. " runner" })
					end

					if M.opts.enable_makeprg and runner.run then
						set_makeprg(bufnr, runner.run)
					end
				end,
			})
		else
		end
	end
end

return M
