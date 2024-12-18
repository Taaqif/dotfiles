return {
  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        left = "<C-S-Left>",
        right = "<C-S-Right>",
        down = "<C-S-Down>",
        up = "<C-S-Up>",

        line_left = "<C-S-Left>",
        line_right = "<C-S-Right>",
        line_down = "<C-S-Down>",
        line_up = "<C-S-Up>",
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        trigger = {
          show_on_trigger_character = false,
        },
      },
    },
  },
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "let", "const" } }),
        },
      })
    end,
  },
  {
    "Wansmer/treesj",
    keys = {
      { "<C-Down>", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "L3MON4D3/LuaSnip",
    config = function(_, opts)
      local luasnip = require("luasnip")
      luasnip.setup(opts)
      luasnip.filetype_extend("typescript", { "javascript" })
      luasnip.filetype_extend("typescriptreact", { "javascript" })
    end,
  },
}
