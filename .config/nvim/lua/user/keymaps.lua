local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Naviagate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>", opts)

-- Insert --
-- Press jk fast to enter
--keymap("i", "jk", "<ESC>", opts)
keymap("i", "<c-z>", "<c-o>:u<CR>", opts)
-- keymap("i", "<C-w>", "<C-\><C-o>dB", opts)
keymap("i", "<C-BS>", "<C-\\><C-o>dB", opts)
-- keymap("i", "<C-BS>", "<C-\\><C-o>dB", opts)
-- keymap("i", "<C-v>", "<c-r>*", opts)
keymap("i", "<C-v>", "<esc>:set paste<cr>a<c-r>=getreg('*')<cr><esc>:set nopaste<cr>mi`[=`]`ia", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
keymap("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- temrinal
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- Custom
-- keymap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)h
-- NOTE: the fact that tab and ctrl-i are the same is stupid
-- keymap("n", "<TAB>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "Q", "<cmd>Bdelete<CR>", opts)

-- cutlass
keymap("n", "x", "d", opts)
keymap("x", "x", "d", opts)
keymap("n", "xx", "dd", opts)
keymap("n", "X", "D", opts)

-- command mode
keymap("c", "<C-v>", "<c-r>*", opts)

-- prevent ctrl-z terminating on windows
if vim.fn.has("win32") and vim.fn.has("nvim") then
	keymap("n", "<C-z>", " <Nop>", opts)
	keymap("i", "<C-z>", " <Nop>", opts)
	keymap("v", "<C-z>", " <Nop>", opts)
	keymap("s", "<C-z>", " <Nop>", opts)
	keymap("x", "<C-z>", " <Nop>", opts)
	keymap("c", "<C-z>", " <Nop>", opts)
	keymap("o", "<C-z>", " <Nop>", opts)
end
