return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	enabled = true,
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("barbecue").setup({
			create_autocmd = false, -- prevent barbecue from updating itself automatically
			show_modified = true,
			attach_navic = false,
		})

		vim.api.nvim_create_autocmd({
			"WinResized",
			"BufWinEnter",
			"CursorHold",
			"InsertLeave",

			"BufWritePost",
			"TextChanged",
			"TextChangedI",
		}, {
			group = vim.api.nvim_create_augroup("barbecue.updater", {}),
			callback = function()
				require("barbecue.ui").update()
			end,
		})
	end,
}
