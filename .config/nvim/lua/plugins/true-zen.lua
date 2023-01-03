return {
  "Pocco81/true-zen.nvim",
  cmd = { "TZFocus", "TZMinimalist" },
  init = function()
    local keymap = require("utils").keymap

    local wk = require("which-key")

    wk.register({
      ["<leader>z"] = { name = "Zen" },
    })

    keymap("n", "<leader>zf", ":TZFocus<CR>", "Focus")
    keymap("n", "<leader>zm", ":TZMinimalist<CR>", "Minimal")
  end,
  config = function()
    require("true-zen").setup({
      -- your config goes here
      -- or just leave it empty :)
    })
  end,
}
