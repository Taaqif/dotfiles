return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({})
		end,
	},
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	"tpope/vim-repeat",
	"AndrewRadev/switch.vim",
	"moll/vim-bbye",
	"andymass/vim-matchup",
	"wellle/targets.vim",
	"folke/lsp-colors.nvim"
}
