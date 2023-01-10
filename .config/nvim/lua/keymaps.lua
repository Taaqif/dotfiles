local term_opts = { silent = true }

-- Shorten function name
local keymap = require("utils").keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Leader mappings --
keymap("n", "<leader>h", ":nohlsearch<CR>", "Clear Highlights")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Naviagate buffers
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>")
keymap("n", "<A-k>", "<Esc>:m .-2<CR>")

-- navigate through wrapped lines
keymap("n", "j", "v:count ? 'j' : 'gj'", {expr = true, noremap = true})
keymap("n", "k", "v:count ? 'k' : 'gk'", {expr = true, noremap = true})
-- Insert --
keymap("i", "<c-z>", "<c-o>:u<CR>")
-- keymap("i", "<C-w>", "<C-\><C-o>dB")
keymap("i", "<C-BS>", "<C-\\><C-o>dB")
-- keymap("i", "<C-BS>", "<C-\\><C-o>dB")
-- keymap("i", "<C-v>", "<c-r>*")
keymap("i", "<C-v>", "<esc>:set paste<cr>a<c-r>=getreg('*')<cr><esc>:set nopaste<cr>mi`[=`]`ia")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
keymap("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>')

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")
-- keymap("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- temrinal
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- Custom
keymap("n", "Q", "<cmd>Bdelete<CR>")

-- cutlass
keymap("n", "x", "d")
keymap("x", "x", "d")
keymap("n", "xx", "dd")
keymap("n", "X", "D")

-- command mode
keymap("c", "<C-v>", "<c-r>*")

-- prevent ctrl-z terminating on windows
if vim.fn.has("win32") and vim.fn.has("nvim") then
	keymap("n", "<C-z>", " <Nop>")
	keymap("i", "<C-z>", " <Nop>")
	keymap("v", "<C-z>", " <Nop>")
	keymap("s", "<C-z>", " <Nop>")
	keymap("x", "<C-z>", " <Nop>")
	keymap("c", "<C-z>", " <Nop>")
	keymap("o", "<C-z>", " <Nop>")
end
