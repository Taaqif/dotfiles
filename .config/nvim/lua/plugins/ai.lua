return {
  {
    "zbirenbaum/copilot.lua",
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>at",
        function()
          local c = require("copilot.client")
          if c.is_disabled() then
            require("copilot.command").enable()
            vim.notify("Copilot enabled", vim.log.levels.INFO)
          else
            require("copilot.command").disable()
            vim.notify("Copilot disabled", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle (Copilot)",
        mode = { "n", "v" },
      },
    },
  },
}
