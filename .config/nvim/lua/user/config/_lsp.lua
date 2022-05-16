local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")

local nlspsettings_ok, nlspsettings = pcall(require, "nlspsettings")
local lsp_format_ok, lsp_format = pcall(require, "lsp-format")
local illuminate_ok, illuminate = pcall(require, "illuminate")


if not lspconfig_ok or not lsp_installer_ok or not nlspsettings_ok then
	return
end

require("user.config._null_ls")

local util = lspconfig.util

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

local servers_config = {
	emmet_ls = {
		filetypes = { "html", "css", "scss", "sass", "javascript", "javascriptreact", "typescriptreact" },
	},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
	sumneko_lua = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
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

nlspsettings.setup({
	config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
	local_settings_dir = ".nlsp-settings",
	local_settings_root_markers = { ".git" },
	append_default_schemas = true,
	loader = "json",
})

if lsp_format_ok then
	lsp_format.setup({})
end

function on_attach(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local function map(key, cmd)
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(0, "n", key, "<cmd>" .. cmd .. "<CR>", opts)
	end

	map("gD", "lua vim.lsp.buf.declaration()")
	map("gd", "lua vim.lsp.buf.definition()")
	map("K", "lua vim.lsp.buf.hover()")
	map("gI", "TroubleToggle lsp_implementations")
	map("gr", "TroubleToggle lsp_references")
	-- map("gI", "lua vim.lsp.buf.implementation()")
	-- map("gr", "lua vim.lsp.buf.references()")
	map("gl", "lua vim.diagnostic.open_float()")
	map("[d", "lua vim.diagnostic.goto_prev()")
	map("]d", "lua vim.diagnostic.goto_next()")
	-- map("<leader>q", "vim.diagnostic.setloclist()")

	local lsp_signature = require("lsp_signature")
	if lsp_signature then
		local options = {
			bind = true,
			doc_lines = 5,
			floating_window = true,
			fix_pos = true,
			hint_enable = true,
			hint_prefix = " ",
			hint_scheme = "String",
			hi_parameter = "Search",
			max_height = 22,
			max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
			handler_opts = {
				border = "single", -- double, single, shadow, none
			},
			zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
			padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
			toggle_key = "<A-k>" 
		}
		lsp_signature.on_attach(options)
	end

	if illuminate_ok then
		illuminate.on_attach(client)
	end

	if lsp_format_ok then
		lsp_format.on_attach(client)
	end


	if client.name ~= "null-ls" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "tsserver" then
		local ts_utils = require("nvim-lsp-ts-utils")
		if ts_utils then
			ts_utils.setup({})
			ts_utils.setup_client(client)
		end
	end
end

local global_capabilities = vim.lsp.protocol.make_client_capabilities()
global_capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp_nvim_lsp = require("cmp_nvim_lsp")
if cmp_nvim_lsp then
	global_capabilities = cmp_nvim_lsp.update_capabilities(global_capabilities)
end

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
	capabilities = global_capabilities,
})

lsp_installer.on_server_ready(function(server)
	local config = servers_config[server.name] or {}
	config.capabilities = global_capabilities
	config.on_attach = on_attach
	server:setup(config)
end)
