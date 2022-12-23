return {
  "L3MON4D3/LuaSnip",

  dependencies = {
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local luasnip = require("luasnip")
    luasnip.setup({
      region_check_events = "CursorHold,InsertLeave,InsertEnter",
      delete_check_events = "TextChanged,InsertEnter,InsertLeave",
    })

    luasnip.filetype_extend("typescript", { "javascript" })
    luasnip.filetype_extend("typescriptreact", { "javascript" })
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets/" })

  end,
}
