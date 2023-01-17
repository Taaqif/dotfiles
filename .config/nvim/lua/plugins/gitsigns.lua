return {
	"lewis6991/gitsigns.nvim",

	event = "BufReadPre",
	init = function()
		local keymap = require("utils").keymap
		local wk = require("which-key")
		wk.register({
			["<leader>g"] = { name = "GIT" },
		})

		keymap("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk")
		keymap("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk")
		keymap("n", "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<cr>", "Blame")
		keymap("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk")
		keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk")
		keymap("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer")
		keymap("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk")
		keymap("n", "<leader>gS", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer")
		keymap("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk")
		keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", "Diff")
	end,
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { hl = "GitSignsAdd", text = "▎" },
				change = { hl = "GitSignsChange", text = "▎" },
				delete = { hl = "GitSignsDelete", text = "契" },
				topdelete = { hl = "GitSignsDelete", text = "契" },
				changedelete = { hl = "GitSignsChange", text = "▎" },
			},
		})
	end,
}
