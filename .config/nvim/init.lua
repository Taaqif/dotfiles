if vim.fn.exists 'g:vscode' == 1 then
  require("vscode")
else
  require("options")
  require("autocmd")
  require("keymaps")
  require("plugins")
  require("theme")
end
