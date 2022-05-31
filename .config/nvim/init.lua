if not vim.g.vscode then
  require("user.options")
  require("user.autocmd")
  require("user.keymaps")
  require("user.plugins")
  require("user.theme")
else
  require("user.vscode")
end
