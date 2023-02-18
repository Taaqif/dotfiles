return {
	"akinsho/toggleterm.nvim",
	lazy = true,
	cmd = {
		"ToggleTerm",
	},
	init = function()
		local keymap = require("utils").keymap
		local wk = require("which-key")

		wk.register({
			["<leader>t"] = { name = "Terminal" },
		})
		keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", "ToggleTerm float")
		keymap("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "ToggleTerm horizontal split")
		keymap("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", "ToggleTerm vertical split")
		keymap("n", "<leader>t1", "<cmd>1ToggleTerm<cr>", "ToggleTerm 1")
		keymap("n", "<leader>t2", "<cmd>2ToggleTerm<cr>", "ToggleTerm 2")
		keymap("n", "<leader>t3", "<cmd>3ToggleTerm<cr>", "ToggleTerm 3")
		keymap("n", "<leader>t4", "<cmd>4ToggleTerm<cr>", "ToggleTerm 4")

		keymap("n", "<leader>ts", "<cmd>ToggleTermSendCurrentLine<cr>", "ToggleTerm Send Current Line")
		keymap("v", "<leader>ts", ":ToggleTermSendVisualSelection<cr>", "ToggleTerm Send Visual Selection")

		keymap("n", "<leader>gg", function()
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				hidden = true,
			})
			lazygit:toggle()
		end, "LazyGit")
	end,
	config = function()
		require("toggleterm").setup({
			size = 10,
			open_mapping = [[<C-\>]],
			direction = "float",
			highlights = {
				Normal = {
					link = "NormalFloat",
				},
				NormalFloat = {
					link = "NormalFloat",
				},
				FloatBorder = {
					link = "FloatBorder",
				},
			},
		})
	end,
}
