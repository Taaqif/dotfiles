return {
  "j-hui/fidget.nvim",
  event = "BufRead",

  config = function()
    require("fidget").setup({
      text = {
        spinner = "dots_snake",
      },
      window = {
        blend = 0,
      },
    })
  end,
}
