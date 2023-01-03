return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({})
		end,
	},
	{"nvim-lua/plenary.nvim", event = "VeryLazy"},
	{"MunifTanjim/nui.nvim", event = "VeryLazy"},
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{"tpope/vim-repeat", event = "VeryLazy"},
	{"moll/vim-bbye", event = "VeryLazy"},
	{"andymass/vim-matchup", event = "BufRead"},
	{"wellle/targets.vim", event = "BufRead"},
	{"folke/lsp-colors.nvim", event = "VeryLazy"}
}
