local illuminate_ok, illuminate = pcall(require, "illuminate")
local navic_ok, navic = pcall(require, "nvim-navic")

local M = {}

local map = require("utils").keymap

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.preselectSupport = true
M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
M.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
M.capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

M.on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	local enable_trouble = true

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	map("n", "<leader>lf", function()
		vim.lsp.buf.format()
	end, { desc = "Format code", buffer = bufnr })
	map("n", "<leader>la", function()
		vim.lsp.buf.code_action()
	end, { desc = "LSP code action", buffer = bufnr })
	map("n", "<leader>lR", function()
		vim.lsp.buf.rename()
	end, { desc = "Rename current symbol", buffer = bufnr })

	map("n", "K", function()
		vim.lsp.buf.hover()
	end, { desc = "Hover symbol details", buffer = bufnr })

	if enable_trouble then
		map("n", "<leader>ll", ":TroubleToggle<CR>", { desc = "Trouble document Diagnostics" })
		map("n", "gd", ":Trouble lsp_definitions<CR>", { desc = "Goto Definition" })
		map("n", "gr", ":Trouble lsp_references<CR>", { desc = "References" })
		map("n", "gD", ":Trouble lsp_declarations<CR>", { desc = "Goto Declaration" })
		map("n", "gi", ":Trouble lsp_implementations<CR>", { desc = "Goto Implementation" })
		map("n", "gt", ":Trouble lsp_type_definitions<CR>", { desc = "Goto Type Definition" })
	else
		map("n", "gd", function()
			vim.lsp.buf.definition()
		end, { desc = "Show the definition of current symbol", buffer = bufnr })
		map("n", "gr", function()
			vim.lsp.buf.references()
		end, { desc = "References of current symbol", buffer = bufnr })
		map("n", "gD", function()
			vim.lsp.buf.declaration()
		end, { desc = "Declaration of current symbol", buffer = bufnr })
		map("n", "gi", function()
			vim.lsp.buf.implementation()
		end, { desc = "Implementation of current symbol", buffer = bufnr })
	end

		map({ "n", "i" }, "<C-k>", function()
			vim.lsp.buf.signature_help()
		end, { desc = "Show signature help", buffer = bufnr })
	map("n", "<leader>ld", function()
		vim.diagnostic.open_float()
	end, { desc = "Hover diagnostics", buffer = bufnr })
	map("n", "[d", function()
		vim.diagnostic.goto_prev()
	end, { desc = "Previous diagnostic", buffer = bufnr })
	map("n", "[D", function()
		vim.diagnostic.goto_prev({
			severity = vim.diagnostic.severity.ERROR,
		})
	end, { desc = "Previous error diagnostic", buffer = bufnr })
	map("n", "]d", function()
		vim.diagnostic.goto_next()
	end, { desc = "Next diagnostic", buffer = bufnr })
	map("n", "]D", function()
		vim.diagnostic.goto_next({

			severity = vim.diagnostic.severity.ERROR,
		})
	end, { desc = "Next error diagnostic", buffer = bufnr })
	map("n", "gl", function()
		vim.diagnostic.open_float()
	end, { desc = "Hover diagnostics", buffer = bufnr })

	local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if cmp_nvim_lsp_ok then
		M.capabilities = cmp_nvim_lsp.default_capabilities()
	end

	if illuminate_ok then
		illuminate.on_attach(client)
	end

	if navic_ok then
		navic.attach(client, bufnr)
	end
end

return M
