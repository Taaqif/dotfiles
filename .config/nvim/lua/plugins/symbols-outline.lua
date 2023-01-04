return {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
  init = function()
    local keymap = require("utils").keymap
    keymap("n", "<leader>lo", "<cmd>SymbolsOutline<cr>", "Show symbols outline")
  end,
  config = function()
    require("symbols-outline").setup()
  end,
}
