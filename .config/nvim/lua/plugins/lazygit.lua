return {
	"kdheepak/lazygit.nvim",
	cmd = { "LazyGit" },
	init = function()
		local keymap = require("utils").keymap

		keymap("n", "<leader>gg", "<cmd>LazyGit<cr>", "LazyGit")
	end,
	config = function()
		vim.g.lazygit_floating_window_use_plenary = 0
	end,
}
