return {
	"rcarriga/nvim-notify",
	lazy = false,
	init = function()
		local wk = require("which-key")
		wk.register({
			["<leader>n"] = { name = "Notify" },
		})

		local map = require("utils").keymap
		map("n", "<leader>nd", function()
			require("notify").dismiss({ silent = true, pending = true })
		end, "Delete all Notifications")
	end,
	config = function()
		require("notify").setup({
			level = "info",
			stages = "fade",
		})
		vim.notify = require("notify")
	end,
}
