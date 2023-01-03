return {
	"nvim-pack/nvim-spectre",
	event = "VeryLazy",
	init = function()
		local keymap = require("utils").keymap
		local wk = require("which-key")
		wk.register({
			["<leader>r"] = { name = "Replace" },
		})
		keymap("n", "<leader>rr", "<cmd>lua require('spectre').open()<cr>", "Replace")
		keymap("n", "<leader>rw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word")
		keymap("n", "<leader>rf", "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer")
	end,
	config = function()
		require("spectre").setup({
			find_engine = {
				["rg"] = {
					args = {
						"--hidden",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
				},
			},
		})
	end,
}
