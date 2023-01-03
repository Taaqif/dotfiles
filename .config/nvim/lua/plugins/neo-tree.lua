return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"mrbjarksen/neo-tree-diagnostics.nvim",
		"s1n7ax/nvim-window-picker",
	},
	init = function()
		local keymap = require("utils").keymap

		keymap("n", "<leader>e", ":Neotree toggle<CR>", "Toggle Explorer")
		keymap("n", "<leader>b", ":Neotree toggle buffers<CR>", "Toggle Buffers")
	end,
	config = function()
		require("neo-tree").setup({
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"diagnostics",
			},
			close_if_last_window = true,
			source_selector = {
				winbar = true,
				content_layout = "center",
			},
			filesystem = {
				follow_current_file = true,
				use_libuv_file_watcher = true,
				hijack_netrw_behavior = "open_current",
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					never_show = {
						".git",
					},
				},
			},
			window = {
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
				},
			},
			buffers = {
				window = {
					mappings = {
						["l"] = "open",
						["h"] = "close_node",
					},
				},
			},
			git_status = {
				window = {
					mappings = {
						["l"] = "open",
						["h"] = "close_node",
					},
				},
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function(_)
						vim.opt_local.signcolumn = "auto"
						vim.cmd([[
            setlocal relativenumber
            ]])
					end,
				},
				{
					event = "file_opened",
					handler = function(file_path)
						--auto close
						require("neo-tree").close_all()
					end,
				},
			},
		})
	end,
}
