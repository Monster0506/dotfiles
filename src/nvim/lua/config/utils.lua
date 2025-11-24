local M = {}
function M.is_quickfix_open()
	for _, winid in ipairs(vim.api.nvim_list_wins()) do
		if vim.bo[vim.api.nvim_win_get_buf(winid)].buftype == "quickfix" then
			return true
		end
	end
	return false
end

function M.cnext_wrap()
	local ok = pcall(vim.cmd, "cnext")
	if not ok then
		pcall(vim.cmd, "cfirst")
	end
end

function M.cprev_wrap()
	local ok = pcall(vim.cmd, "cprev")
	if not ok then
		pcall(vim.cmd, "clast")
	end
end

return M
