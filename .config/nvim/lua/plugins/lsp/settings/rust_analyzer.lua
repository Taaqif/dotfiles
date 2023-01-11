local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
local _, lspconfig = pcall(require, "lspconfig")
local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
return {
	setup = function(opts)
		if rust_tools_ok and mason_registry_ok then
			local codelldb = mason_registry.get_package("codelldb")
			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
			rust_tools.setup({
				server = opts,
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			})
		else
			lspconfig["rust_analyzer"].setup(opts)
		end
	end,
	on_attach = function(client, bufnr)
		local map = require("utils").keymap
		if rust_tools_ok and mason_registry_ok then
			map("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
			local wk = require("which-key")
			wk.register({
				["<leader>lr"] = { name = "Rust" },
			})

			map(
				"n",
				"<Leader>lra",
				rust_tools.code_action_group.code_action_group,
				{ buffer = bufnr, desc = "Rust code action" }
			)
		end
	end,
}
