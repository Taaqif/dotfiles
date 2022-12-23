return {
  "j-hui/fidget.nvim",
  event = "BufReadPre",

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
