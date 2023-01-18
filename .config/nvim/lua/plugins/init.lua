local keymap = require("utils").keymap

keymap("n", "<leader>L", ":Lazy<CR>", "Lazy")

return {
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup({})
		end,
	},
	{"nvim-lua/plenary.nvim", lazy = true},
	{"MunifTanjim/nui.nvim", lazy = true},
	{ "stevearc/dressing.nvim", lazy = true },
	{"tpope/vim-repeat", event = "VeryLazy"},
	{"moll/vim-bbye", event = "VeryLazy"},
	{"andymass/vim-matchup", event = "BufRead"},
	{"wellle/targets.vim", event = "BufRead"},
	{"folke/lsp-colors.nvim", event = "VeryLazy"}
}
