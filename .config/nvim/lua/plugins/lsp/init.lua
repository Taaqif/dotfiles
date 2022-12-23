local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"nvim-lua/lsp-status.nvim",
		"b0o/schemastore.nvim",
		"jose-elias-alvarez/typescript.nvim",
		"SmiteshP/nvim-navic",
		"RRethy/vim-illuminate",
		"RishabhRD/nvim-lsputils",
		"jose-elias-alvarez/null-ls.nvim",
	},
	event = "BufReadPre",
	init = function()
		local wk = require("which-key")
		wk.register({
			["<leader>l"] = { name = "LSP" },
		})
	end,
}

function M.config()
	local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
	local mason = require("mason")
	local mason_lspconfig = require("mason-lspconfig")

	local navic_ok, navic = pcall(require, "nvim-navic")

	if navic_ok then
		vim.g.navic_silence = true
		navic.setup({
			highlight = true,
			separator = "   ",
		})
	end

	local util = lspconfig.util
	mason.setup({})
	mason_lspconfig.setup({})

	require("plugins.lsp.null_ls")
	local icons = require("icons")
	local signs = {
		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	vim.diagnostic.config({
		underline = true,
		virtual_text = {
			spacing = 5,
			prefix = "",
			severity_limit = "Warning",
			format = function(diagnostic)
				-- hide Info and hints from vtext
				if
					diagnostic.severity == vim.diagnostic.severity.INFO
					or diagnostic.severity == vim.diagnostic.severity.HINT
				then
					return nil
				else
					return diagnostic.message
				end
			end,
		},
		update_in_insert = false,
		signs = {
			active = signs,
		},
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	local servers = {}

	for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
		table.insert(servers, server)
	end
	for _, server in ipairs(servers) do
		local status_ok, server_opts = pcall(require, "config.lsp.settings." .. server)
		local opts = {
			capabilities = require("plugins.lsp.handlers").capabilities,
		}
		if status_ok then
			opts = vim.tbl_deep_extend("force", server_opts, opts)
			opts["setup"] = nil
		end
		opts.on_attach = function(client, bufnr)
			if status_ok and type(server_opts.on_attach) == "function" then
				server_opts.on_attach(client, bufnr)
			end
			require("plugins.lsp.handlers").on_attach(client, bufnr)
		end
		if status_ok and type(server_opts.setup) == "function" then
			server_opts.setup(opts)
		else
			lspconfig[server].setup(opts)
		end
	end
end

return M
