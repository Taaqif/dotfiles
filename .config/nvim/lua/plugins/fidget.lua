return {
  "j-hui/fidget.nvim",
  event = "BufRead",

  config = function()
    require("fidget").setup({
      text = {
        spinner = "arc",
        done = "",
      },
      window = {
        blend = 0,
      },
      sources = {
        ["null-ls"] = {
          ignore = true,
        },
      },
    })
  end,
}
