if vim.fn.exists 'g:vscode' == 1 then
  require("user.vscode")
else
  require("user.options")
  require("user.autocmd")
  require("user.keymaps")
  require("user.plugins")
  require("user.theme")
end
