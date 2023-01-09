return {
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  init = function ()
    -- TODO: https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b
  end,
  config = function ()
    require("dapui").setup()
  end
}
