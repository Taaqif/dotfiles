-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", "P")

-- make c-v paste instead
map("i", "<C-v>", "<C-r>+", opts)

-- Use the black hole register for the c, d command
map({ "n", "x" }, "c", '"_c', opts)
map({ "n", "x" }, "C", '"_C', opts)
map({ "n", "x" }, "d", '"_d', opts)
map({ "n", "x" }, "D", '"_D', opts)
