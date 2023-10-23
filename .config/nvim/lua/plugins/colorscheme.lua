return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = function()
      local gruvbox = require("gruvbox")
      local pallete = gruvbox.palette
      return {
        transparent_mode = true,
        inverse = false,
        undercurl = false,
        overrides = {
          GruvboxRedUnderline = { underline = true, sp = pallete.bright_red },
          GruvboxGreenUnderline = { underline = true, sp = pallete.bright_green },
          GruvboxYellowUnderline = { underline = true, sp = pallete.bright_yellow },
          GruvboxBlueUnderline = { underline = true, sp = pallete.bright_blue },
          GruvboxPurpleUnderline = { underline = true, sp = pallete.bright_purple },
          GruvboxAquaUnderline = { underline = true, sp = pallete.bright_aqua },
          GruvboxOrangeUnderline = { underline = true, sp = pallete.bright_orange },

          LspInlayHint = { fg = "#524a45" },

          NotifyBackground = { bg = pallete.dark1 },

          FloatTitle = { bg = pallete.dark_red, fg = pallete.dark1 },
          FloatBorder = { fg = pallete.dark1, bg = pallete.dark1 },
          NormalFloat = { bg = pallete.dark1 },

          NeoTreeFloatTitle = { bg = pallete.dark_red, fg = pallete.light1 },
          NeoTreeFloatBorder = { fg = pallete.dark1, bg = pallete.dark1 },
          NeoTreeNormal = { bg = pallete.dark1 },
          NeoTreeFloatNormal = { bg = pallete.dark2 },
          NeoTreeNormalNC = { bg = pallete.dark1 },
          NeoTreeCursorLine = { bg = pallete.dark2 },

          NoiceCmdlinePopup = { bg = pallete.dark2 },
          NoiceCmdlinePopupBorder = { fg = pallete.dark2, bg = pallete.dark2 },
          NoiceCmdlinePopupTitle = { bg = pallete.dark_red, fg = pallete.light1 },
          NoiceCmdlinePopupResults = { bg = pallete.dark1 },
          NoiceCmdlinePopupResultsBorder = { bg = pallete.dark1, fg = pallete.dark1 },
          NoiceMini = { bg = pallete.dark2 },

          TelescopeResultsTitle = { fg = pallete.dark1, bg = pallete.dark1 },
          TelescopePreviewTitle = { fg = pallete.dark1, bg = pallete.dark1 },
          TelescopeTitle = { bg = pallete.dark_red, fg = pallete.light1 },
          TelescopePromptNormal = { bg = pallete.dark2 },
          TelescopePromptBorder = { fg = pallete.dark2, bg = pallete.dark2 },
          TelescopeResultsNormal = { bg = pallete.dark1 },
          TelescopeResultsBorder = { fg = pallete.dark1, bg = pallete.dark1 },
          TelescopePreviewNormal = { bg = pallete.dark1 },
          TelescopePreviewBorder = { bg = pallete.dark1, fg = pallete.dark1 },
        },
        contrast = "soft",
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
