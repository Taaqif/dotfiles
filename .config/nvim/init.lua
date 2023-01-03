if vim.fn.exists 'g:vscode' == 1 then
  require("vscode")
else
  require("options")
  require("keymaps")
  require("lazy-plugins")
  require("autocmd")
  require("highlights")
end
