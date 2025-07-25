local lspconfig = require("lspconfig")
Capabilities = vim.lsp.protocol.make_client_capabilities()

Capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

On_attach_common = function(client, bufnr)
	local navic = require("nvim-navic")
	navic.attach(client, bufnr)

	local base_opts = { noremap = true, silent = true, buffer = bufnr }

	local map_with_desc = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend("force", base_opts, { desc = desc }))
	end

	-- Common LSP Keymaps
	map_with_desc("n", "K", vim.lsp.buf.hover, "Show hover documentation")
	map_with_desc("n", "<C-k>", vim.lsp.buf.signature_help, "Show function signature")
	map_with_desc("n", "gd", vim.lsp.buf.definition, "Go to definition")
	map_with_desc("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
	map_with_desc("n", "grt", vim.lsp.buf.type_definition, "Go to type definition")
	map_with_desc("n", "gri", vim.lsp.buf.implementation, "Go to implementation")
	map_with_desc("n", "grn", vim.lsp.buf.rename, "Rename symbol")
	map_with_desc("n", "gra", vim.lsp.buf.code_action, "Show code actions")
	map_with_desc("v", "gra", vim.lsp.buf.code_action, "Show code actions (Visual)")
	map_with_desc("n", "grr", vim.lsp.buf.references, "Show references")
	map_with_desc("n", "gO", vim.lsp.buf.document_symbol, "Show document symbols")
	map_with_desc("i", "<C-s>", vim.lsp.buf.signature_help, "Show signature help (Insert)")
	map_with_desc("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
	map_with_desc("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
end

lspconfig.clangd.setup({
	capabilities = Capabilities,
	on_attach = On_attach_common,
})

lspconfig.lua_ls.setup({

	on_attach = On_attach_common,
	capabilities = Capabilities,
})

return { On_attach_common = On_attach_common, Capabilities = Capabilities }
