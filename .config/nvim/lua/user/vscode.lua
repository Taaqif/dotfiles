local o = vim.opt
local map = function(mode, key, cmd, opts)
  vim.api.nvim_set_keymap(mode, key, cmd, opts or { noremap = true, silent = true })
end

vim.opt.rtp:remove(vim.fn.stdpath 'data' .. '/site')
vim.opt.rtp:remove(vim.fn.stdpath 'data' .. '/site/after')
vim.cmd [[let &packpath = &runtimepath]]
  
o.backup = false
o.writebackup = false
o.swapfile = false
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.virtualedit = 'block'
o.clipboard = 'unnamedplus'
o.iskeyword = o.iskeyword + '-'

vim.g.mapleader = ' '

map('n', 'Q', '<Nop>')
map('n', 'q:', '<Nop>')
map('n', '<C-c>', '<Esc>')
map('n', 'Y', 'y$')
map('n', '<CR>', '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true })
map('n', 'x', '"_x')
map('n', 'X', '"_X')

map('x', '<', '<gv')
map('x', '>', '>gv')
map('x', 'K', ":move '<-2<CR>gv-gv")
map('x', 'J', ":move '>+1<CR>gv-gv")

-- Better navigation
map('n', '<C-j>', '<cmd>call VSCodeNotify("workbench.action.navigateDown")<CR>')
map('n', '<C-k>', '<cmd>call VSCodeNotify("workbench.action.navigateUp")<CR>')
map('n', '<C-h>', '<cmd>call VSCodeNotify("workbench.action.navigateLeft")<CR>')
map('n', '<C-l>', '<cmd>call VSCodeNotify("workbench.action.navigateRight")<CR>')

-- Commentary
map('x', 'gc', '<Plug>VSCodeCommentary', { noremap = false })
map('n', 'gc', '<Plug>VSCodeCommentary', { noremap = false })
map('o', 'gc', '<Plug>VSCodeCommentary', { noremap = false })
map('n', 'gcc', '<Plug>VSCodeCommentaryLine', { noremap = false })
