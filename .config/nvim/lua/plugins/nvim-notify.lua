return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    require("notify").setup({
      level = "info",
      stages = "slide",
      background_colour = "#282A36",
    })
    vim.notify = require("notify")
  end,
}
