return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    lazy = false,
    keys = {
      { "<leader>h", "", desc = "+hardtime", mode = { "n", "v" } },
      {
        "<leader>hr",
        function()
          vim.cmd("Hardtime report")
        end,
        desc = "Hardtime report",
        mode = { "n", "v" },
      },
      {
        "<leader>ht",
        function()
          vim.cmd("Hardtime toggle")
        end,
        desc = "Toggle (Hardtime)",
        mode = { "n", "v" },
      },
      { "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"' },
      { "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"' },
    },
    opts = {
      disabled_keys = {
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {},
      },
      disable_mouse = false,
    },
  },
}
