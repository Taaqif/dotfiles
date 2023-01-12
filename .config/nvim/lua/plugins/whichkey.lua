return {
	"folke/which-key.nvim",
	lazy = true,
	config = function()
		local wk = require("which-key")

		wk.setup({
			plugins = {
				spelling = {
					enabled = true,
				},
			},
			key_labels = {
				["<space>"] = "SPC",
				["<cr>"] = "RET",
				["<tab>"] = "TAB",
			},
		})
	end,
}
