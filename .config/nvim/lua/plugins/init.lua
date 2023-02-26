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
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = false },
	{
		"stevearc/dressing.nvim",
		lazy = false,
		config = function()
			require("dressing").setup({
				input = {
					prompt_align = "center",
					relative = "win",
				},
			})
		end,
	},
	{ "tpope/vim-repeat", event = "BufRead" },
	{ "moll/vim-bbye", event = "BufRead" },
	{ "andymass/vim-matchup", event = "BufRead" },
	{ "wellle/targets.vim", lazy = false },
	{ "wakatime/vim-wakatime", lazy = false },
}
