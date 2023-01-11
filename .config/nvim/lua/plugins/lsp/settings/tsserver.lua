local typescript_ok, typescript = pcall(require, "typescript")
local _, lspconfig = pcall(require, "lspconfig")
return {
	setup = function(opts)
		if typescript_ok then
			typescript.setup({
				server = opts,
			})
		else
			lspconfig["tsserver"].setup(opts)
		end
	end,
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		local wk = require("which-key")
		wk.register({
			["<leader>lt"] = { name = "Typescript" },
		})
		local map = require("utils").keymap
		map("n", "<leader>lta", ":TypescriptAddMissingImports<CR>", "Add missing imports")
		map("n", "<leader>lto", ":TypescriptOrganizeImports<CR>", "Organize imports")
		map("n", "<leader>ltr", ":TypescriptRemoveUnused<CR>", "Remove unused")
		map("n", "<leader>ltf", ":TypescriptFixAll<CR>", "Fix all")
		map("n", "<leader>ltR", ":TypescriptRenameFile<CR>", "Rename file")
		map("n", "<leader>lts", ":TypescriptGoToSourceDefinition<CR>", "Go To Source Definition")

		-- 		local prettier_path = '.\\node_modules\\.bin\\prettier.cmd' -- default to local
		-- local prettier_config = ' --config-precedence file-override --no-semi --use-tabs --single-quote'
		-- -- use our own if project doesn't have
		-- if vim.fn.executable(prettier_path) ~= 1 then
		-- 	prettier_path = lsp_bins .. '\\node_modules\\.bin\\prettier.cmd'
		-- end
	end,
}
