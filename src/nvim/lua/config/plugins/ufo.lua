local ufo = require("ufo")

local handler = function(virt_text, lnum, end_lnum, width, truncate)
	local folded_lines = end_lnum - lnum
	local suffix = string.format(" 󰁂 %d ", folded_lines)
	local suf_width = vim.fn.strdisplaywidth(suffix)
	local target_width = width - suf_width
	local cur_width = 0
	local new_virt_text = {}

	for _, chunk in ipairs(virt_text) do
		local chunk_text = chunk[1]
		local hl_group = chunk[2]
		local chunk_width = vim.fn.strdisplaywidth(chunk_text)
		if target_width > cur_width + chunk_width then
			table.insert(new_virt_text, chunk)
		else
			chunk_text = truncate(chunk_text, target_width - cur_width)
			table.insert(new_virt_text, { chunk_text, hl_group })
			local padding = target_width - cur_width - vim.fn.strdisplaywidth(chunk_text)
			if padding > 0 then
				suffix = suffix .. string.rep(" ", padding)
			end
			break
		end
		cur_width = cur_width + chunk_width
	end
	table.insert(new_virt_text, { suffix, "MoreMsg" })
	return new_virt_text
end

ufo.setup({
	fold_virt_text_handler = handler,
	enable_get_fold_virt_text = false,
	open_fold_hl_timeout = 150,
})
