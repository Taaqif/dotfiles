local nvim_tree = require "nvim-tree"
local nvim_tree_config = require "nvim-tree.config"
local tree_cb = nvim_tree_config.nvim_tree_callback
vim.g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

nvim_tree.setup {
    filters = {
        dotfiles = false,
        custom = { '.git' }
    },
    disable_netrw = true,
    hijack_netrw = true,
    ignore_ft_on_setup = { "dashboard" },
    open_on_tab = false,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
    },
    view = {
        side = "left",
        width = 25,
        hide_root_folder = false,
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
                { key = '<C-R>', cb = tree_cb 'refresh' },
            },
        },

    },
    git = {
        enable = true,
        ignore = false,
    },
    actions = {
        open_file = {
            resize_window = true,
        },
    },
    renderer = {
        indent_markers = {
            enable = true,
        }
    }
}
