local ok, neotree = pcall(require, "neo-tree")

if not ok then
	return
end

neotree.setup({
	filesystem = {
		follow_current_file = true,
		use_libuv_file_watcher = true,
		filtered_items = {
			visible = true,
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
	git_status  = {
		window = {
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
			},
		}
	},
})
