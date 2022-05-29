local ok, nvim_tree = pcall(require, "nvim-tree")

if not ok then
    return
end

local nvim_tree_config = require "nvim-tree.config"
local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
    filters = {
        -- dotfiles = false,
        custom = { '^\\.git$' }
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
    respect_buf_cwd = true,
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
        timeout=200
    },
    actions = {
        open_file = {
            resize_window = true,
        },
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
        root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },
        icons =  {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    deleted = "",
                    ignored = "◌",
                    renamed = "➜",
                    staged = "✓",
                    unmerged = "",
                    unstaged = "✗",
                    untracked = "★",
                },
            }
        }
    }
}
