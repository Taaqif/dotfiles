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
	{"AndrewRadev/switch.vim", event = "VeryLazy"},
	{"moll/vim-bbye", event = "VeryLazy"},
	{"andymass/vim-matchup", event = "BufReadPre"},
	{"wellle/targets.vim", event = "BufReadPre"},
	{"folke/lsp-colors.nvim", event = "VeryLazy"}
}
