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
		local icons = require("icons")
		require("barbecue").setup({
			create_autocmd = false, -- prevent barbecue from updating itself automatically
			show_modified = true,
			attach_navic = false,
			kinds = icons.kind
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
