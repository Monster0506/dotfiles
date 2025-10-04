local M = {}

function M.setup()
	-- Set filetype when opening .tj or .tjlang files
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = { "*.tj", "*.tjlang" },
		callback = function()
			vim.bo.filetype = "tjlang"
		end,
	})

	-- On FileType tjlang, apply our syntax highlights
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "tjlang",
		callback = function()
			-- Create a new namespace for our highlights
			local ns = vim.api.nvim_create_namespace("tjlang_syntax")

			----------------------------------------------------------------------
			-- Helper function for keywords
			----------------------------------------------------------------------
			local function keyword(group, words, link)
				for _, w in ipairs(words) do
					vim.fn.matchadd(group, "\\<" .. w .. "\\>", 10, -1, { window = 0 })
				end
				vim.api.nvim_set_hl(0, group, { link = link })
			end

			----------------------------------------------------------------------
			-- Keywords
			----------------------------------------------------------------------
			keyword("TjlangKeyword", {
				"def",
				"return",
				"break",
				"continue",
				"pass",
				"raise",
				"if",
				"elif",
				"else",
				"while",
				"for",
				"match",
				"do",
				"module",
				"import",
				"from",
				"export",
				"as",
				"type",
				"enum",
				"interface",
				"impl",
				"spawn",
				"implements",
				"extends",
				"not",
				"true",
				"false",
				"None",
			}, "Keyword")

			----------------------------------------------------------------------
			-- Types
			----------------------------------------------------------------------
			keyword("TjlangType", { "int", "float", "bool", "str", "any" }, "Type")
			vim.fn.matchadd("TjlangType", "\\<[A-Z][A-Za-z0-9_]*\\>", 10, -1, { window = 0 })
			vim.api.nvim_set_hl(0, "TjlangType", { link = "Type" })

			----------------------------------------------------------------------
			-- Functions
			----------------------------------------------------------------------
			vim.fn.matchadd("TjlangFunction", "\\<[a-zA-Z_][A-Za-z0-9_]*\\s*\\ze(", 10, -1, { window = 0 })
			vim.api.nvim_set_hl(0, "TjlangFunction", { link = "Function" })

			----------------------------------------------------------------------
			-- Operators
			----------------------------------------------------------------------
			vim.fn.matchadd("TjlangOperator", "[+\\-*/%%<>=!&|^~][=<>]*", 10, -1, { window = 0 })
			keyword("TjlangOperator", { "or", "and", "not" }, "Operator")

			----------------------------------------------------------------------
			-- Strings + f-strings
			----------------------------------------------------------------------
			vim.fn.matchadd("TjlangString", [["[^"]*"]], 10, -1, { window = 0 })
			vim.fn.matchadd("TjlangFString", [[f"[^"]*"]], 10, -1, { window = 0 })
			vim.api.nvim_set_hl(0, "TjlangString", { link = "String" })
			vim.api.nvim_set_hl(0, "TjlangFString", { link = "String" })

			----------------------------------------------------------------------
			-- Numbers
			----------------------------------------------------------------------
			vim.fn.matchadd("TjlangNumber", "\\<[0-9]\\+(\\.[0-9]\\+)?\\>", 10, -1, { window = 0 })
			vim.api.nvim_set_hl(0, "TjlangNumber", { link = "Number" })

			----------------------------------------------------------------------
			-- Comments
			----------------------------------------------------------------------
			vim.fn.matchadd("TjlangComment", "#.*", 10, -1, { window = 0 })
			vim.api.nvim_set_hl(0, "TjlangComment", { link = "Comment" })

			----------------------------------------------------------------------
			-- Braces
			----------------------------------------------------------------------
			vim.fn.matchadd("TjlangBraces", "[{}()\\[\\]]", 10, -1, { window = 0 })
			vim.api.nvim_set_hl(0, "TjlangBraces", { link = "Delimiter" })
		end,
	})
end
return M
