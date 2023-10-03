return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  enabled = false,
	init = function()
		local wk = require("which-key")
		wk.register({
			["<leader>lt"] = { name = "Typescript" },
		})
		local map = require("utils").keymap
		map("n", "<leader>lta", ":TSToolsAddMissingImports<CR>", "Add missing imports")
		map("n", "<leader>lto", ":TSToolsOrganizeImports<CR>", "Organize imports")
		map("n", "<leader>ltr", ":TSToolsRemoveUnused<CR>", "Remove unused")
		map("n", "<leader>ltf", ":TSToolsFixAll<CR>", "Fix all")
		map("n", "<leader>ltR", ":TSToolsRenameFile<CR>", "Rename file")
		map("n", "<leader>lts", ":TSToolsGoToSourceDefinition<CR>", "Go To Source Definition")
	end,
	config = function()
		require("typescript-tools").setup({
			on_attach = function(client)
        -- use prettier from null ls to format
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
			settings = {
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
			},
		})
	end,
}
