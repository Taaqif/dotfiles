return {
  "folke/trouble.nvim",
  cmd = "TroubleToggle",
  init = function()
  end,
  config = function()
    local keymap = require("utils").keymap
    vim.keymap.set("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", {desc = "Toggle LSP reference's"})
    keymap("n", "gd", "<cmd>TroubleToggle lsp_definitions<cr>", "Toggle LSP Definitions")
    require("trouble").setup({
      use_diagnostic_signs = true,
    })
  end,
}
