vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- vim.api.nvim_create_autocmd({ "TextYankPost" }, {
--   callback = function()
--     vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   callback = function()
--     vim.cmd "hi link illuminatedWord LspReferenceText"
--   end,
-- })
