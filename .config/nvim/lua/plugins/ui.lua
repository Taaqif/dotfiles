return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opt)
    opt.config.week_header = {
      enable = true,
    }
    return opt
  end,
}
