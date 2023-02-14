return {
  "ggandor/leap.nvim",
  event = "BufRead",
  config = function()
    local leap = require("leap")
    leap.add_default_mappings()

  end
}
