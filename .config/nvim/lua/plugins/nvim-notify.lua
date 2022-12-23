return {
  "rcarriga/nvim-notify",

  config = function()
    require("notify").setup({
      level = "info",
      stages = "slide",
      background_colour = "#282A36"
    })
    vim.notify = require("notify")

  end
}
