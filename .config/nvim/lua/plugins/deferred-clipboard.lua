return {
  "Taaqif/deferred-clipboard.nvim",
  enabled = true,
  branch = "feature/additional-aucmnd",
  event = "VeryLazy",
  config = function()
    vim.o.clipboard = nil
    require("deferred-clipboard").setup{
      lazy = true,
    }
  end,
}
