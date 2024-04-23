local opt = vim.opt

vim.g.lazygit_config = false

opt.scrolloff = 8
opt.showbreak = "↪ "
opt.wrap = false
opt.spelloptions = "camel"
opt.clipboard = ""

-- if vim.fn.has("wsl") == 1 then
--   vim.g.clipboard = {
--     copy = {
--       ["+"] = "win32yank.exe -i --crlf",
--       ["*"] = "win32yank.exe -i --crlf",
--     },
--     paste = {
--       ["+"] = "win32yank.exe -o --lf",
--       ["*"] = "win32yank.exe -o --lf",
--     },
--   }
-- end
-- opt.list = true
-- opt.listchars = {
--   eol = "↵",
--   trail = "·",
--   space = "·",
--   tab = "  ",
-- }
