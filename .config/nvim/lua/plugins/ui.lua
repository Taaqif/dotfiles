return {
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opt)
      opt.config.week_header = {
        enable = true,
      }
      return opt
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      views = {
        cmdline_popupmenu = {
          win_options = {
            winhighlight = { Normal = "NoiceCmdlinePopupResults", FloatBorder = "NoiceCmdlinePopupResultsBorder" },
          },
        },
      },
    },
  },
}
