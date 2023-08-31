return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"mrbjarksen/neo-tree-diagnostics.nvim",
		"s1n7ax/nvim-window-picker",
	},
	branch = "v3.x",
	init = function()
		local keymap = require("utils").keymap

		keymap("n", "<leader>e", ":Neotree float toggle reveal<CR>", "Toggle Explorer")
		keymap("n", "<leader>b", ":Neotree float toggle buffers reveal<CR>", "Toggle Buffers")
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
			popup_border_style = "rounded",
			source_selector = {
				winbar = true,
				content_layout = "center",
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
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
				position = "float",
				popup = {
					size = { width = "87%", height = "80%" },
				},
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
				-- {
				-- 	event = "file_opened",
				-- 	handler = function(file_path)
				-- 		--auto close
				-- 		require("neo-tree").close_all()
				-- 	end,
				-- },
			},
		})
	end,
}
