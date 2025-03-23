return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    scroll = { enabled = false },
    lazygit = {
      theme = {
        activeBorderColor = { fg = "Special", bold = true },
        inactiveBorderColor = { fg = "Visual" },
      },
    },
  },
  keys = {
    { "<leader>ff", LazyVim.pick("files", { hidden = true }), desc = "Find Files (Root Dir)" },
  },
}
