-- mars-runner.nvim
-- Properly structured Neovim plugin to run Mars MIPS on assembly files

local M = {}

-- Default options
local defaults = {
	jar_path = "C:\\Users\\TJ\\.vscode\\extensions\\ahmz1833.mars-mips-1.0.4\\mars.jar",
	filetypes = { "asm", "mars", "mips" },
	keymaps = {
		run = "<leader>mr",
	},
	use_quickfix = false,
	enable_makeprg = true,
	split_cmd = "vsplit",
}

M.opts = vim.deepcopy(defaults)

-----------------------------------------------------
-- Helpers
-----------------------------------------------------

local function quote_path(path)
	return '"' .. path .. '"'
end

local function build_command(jar_path, filename)
	return string.format("java -jar %s nc me %s", quote_path(jar_path), quote_path(filename))
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

local function run_mars(jar_path)
	local filename = vim.fn.expand("%:p")
	if filename == "" then
		vim.notify("No file associated with current buffer.", vim.log.levels.WARN)
		return
	end

	local shell_type = detect_shell_type()
	local cmd = build_command(jar_path, filename)

	local win, buf = open_split_terminal()
	local job_id = vim.b[buf].terminal_job_id
	if not job_id then
		vim.notify("Failed to start terminal.", vim.log.levels.ERROR)
		return
	end

	-- Compose shell-specific close/wait message logic
	local wait_script
	if shell_type == "pwsh" then
		wait_script = [[; Write-Host "`nPress Enter to close..."; [void][System.Console]::ReadLine(); exit]]
	else
		wait_script = [[; echo -e "\nPress Enter to close..."; read _; exit]]
	end

	-- Combine the command + wait logic
	local full_cmd = cmd .. wait_script

	-- Make sure we're in insert mode so the terminal is active
	vim.cmd("startinsert")

	-- Send the command text
	vim.fn.chansend(job_id, full_cmd)
	-- Send a manual Enter keypress (carriage return)
	vim.fn.chansend(job_id, "\r")

	-- Automatically close terminal window when it exits
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

local function set_makeprg(bufnr, jar_path)
	local esc_jar = vim.fn.escape(jar_path, " \\")
	local cmd = string.format([[setlocal makeprg=java\ -jar\ "%s"\ nc\ me\ "%%"]], esc_jar)
	vim.api.nvim_buf_call(bufnr, function()
		vim.cmd(cmd)
	end)
end

-----------------------------------------------------
-- Setup and autocommands
-----------------------------------------------------

function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", defaults, opts or {})

	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = { "*.asm", "*.s", "*.mars" },
		callback = function(ev)
			vim.bo[ev.buf].filetype = "mips"
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = M.opts.filetypes,
		callback = function(ev)
			local bufnr = ev.buf

			vim.keymap.set("n", M.opts.keymaps.run, function()
				run_mars(M.opts.jar_path)
			end, { buffer = bufnr, desc = "Run Mars in terminal" })

			if M.opts.enable_makeprg then
				set_makeprg(bufnr, M.opts.jar_path)
			end
			vim.cmd([[setlocal commentstring=#\ %s]])

			vim.api.nvim_buf_create_user_command(bufnr, "MarsRun", function()
				run_mars(M.opts.jar_path)
			end, { desc = "Run Mars in terminal" })
		end,
	})
end

return M
