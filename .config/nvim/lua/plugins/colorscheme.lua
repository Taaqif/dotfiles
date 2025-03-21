local function hexToRgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

local blend = function(foreground, background, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hexToRgb(background)
  local fg = hexToRgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end
return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = function()
      local gruvbox = require("gruvbox")
      local pallete = gruvbox.palette
      local palette_overrides = {
        bright_red = "#ea6962",
        bright_green = "#89b482",
        bright_yellow = "#d8a657",
        bright_blue = "#7daea3",
        bright_purple = "#d3869b",
        bright_aqua = "#a9b665",
        bright_orange = "#e78a4e",
      }
      for color, hex in pairs(palette_overrides) do
        pallete[color] = hex
      end
      return {
        transparent_mode = true,
        inverse = false,
        undercurl = true,
        palette_overrides = palette_overrides,
        overrides = {
          GruvboxRedUnderline = { sp = pallete.bright_red },
          GruvboxGreenUnderline = { sp = pallete.bright_green },
          GruvboxYellowUnderline = { sp = pallete.bright_yellow },
          GruvboxBlueUnderline = { sp = pallete.bright_blue },
          GruvboxPurpleUnderline = { sp = pallete.bright_purple },
          GruvboxAquaUnderline = { sp = pallete.bright_aqua },
          GruvboxOrangeUnderline = { sp = pallete.bright_orange },

          LspInlayHint = { fg = "#524a45" },

          NotifyBackground = { bg = pallete.dark1 },

          FloatTitle = { bg = pallete.dark_red, fg = pallete.light1 },
          FloatBorder = { fg = pallete.dark1, bg = pallete.dark1 },
          NormalFloat = { bg = pallete.dark1 },

          NeoTreeFloatTitle = { bg = pallete.dark_red, fg = pallete.light1 },
          NeoTreeFloatBorder = { fg = pallete.dark1, bg = pallete.dark1 },
          NeoTreeNormal = { bg = "NONE" },
          NeoTreeFloatNormal = { bg = pallete.dark2 },
          NeoTreeNormalNC = { bg = "NONE" },
          NeoTreeCursorLine = { bg = pallete.dark2 },

          NoiceCmdlinePopup = { bg = pallete.dark2 },
          NoiceCmdlinePopupBorder = { fg = pallete.dark2, bg = pallete.dark2 },
          NoiceCmdlinePopupTitle = { bg = pallete.dark_red, fg = pallete.light1 },
          NoiceCmdlinePopupResults = { bg = pallete.dark1 },
          NoiceCmdlinePopupResultsBorder = { bg = pallete.dark1, fg = pallete.dark1 },
          -- NoiceMini = { bg = pallete.dark2 },

          TelescopeResultsTitle = { fg = pallete.dark1, bg = pallete.dark1 },
          TelescopePreviewTitle = { fg = pallete.dark1, bg = pallete.dark1 },
          TelescopeTitle = { bg = pallete.dark_red, fg = pallete.light1 },
          TelescopePromptNormal = { bg = pallete.dark2 },
          TelescopePromptBorder = { fg = pallete.dark2, bg = pallete.dark2 },
          TelescopeResultsNormal = { bg = pallete.dark1 },
          TelescopeResultsBorder = { fg = pallete.dark1, bg = pallete.dark1 },
          TelescopePreviewNormal = { bg = pallete.dark1 },
          TelescopePreviewBorder = { bg = pallete.dark1, fg = pallete.dark1 },

          FzfLuaNormal = { bg = pallete.dark1 },
          FzfLuaBorder = { bg = pallete.dark1, fg = pallete.dark1 },
          FzfLuaTitle = { bg = pallete.dark_red, fg = pallete.light1 },
          FzfLuaPreviewNormal = { bg = pallete.dark2 },
          FzfLuaPreviewBorder = { bg = pallete.dark2, fg = pallete.dark2 },

          BufferLineBufferSelected = { bg = pallete.dark2, fg = pallete.light1, bold = true, italic = true },
          BufferLineIndicatorSelected = { bg = pallete.dark2, fg = pallete.light1 },
          BufferLineCloseButtonSelected = { bg = pallete.dark2, fg = pallete.light1 },
          BufferLineModifiedSelected = { bg = pallete.dark2, fg = pallete.bright_green, bold = true, italic = true },
          BufferLineWarningSelected = { bg = pallete.dark2, fg = pallete.bright_yellow, bold = true, italic = true },
          BufferLineWarningDiagnosticSelected = { bg = pallete.dark2, fg = pallete.bright_yellow },
          BufferLineErrorSelected = { bg = pallete.dark2, fg = pallete.bright_red, bold = true, italic = true },
          BufferLineErrorDiagnosticSelected = { bg = pallete.dark2, fg = pallete.bright_red },
          BufferLineInfoSelected = { bg = pallete.dark2, fg = pallete.bright_blue, bold = true, italic = true },
          BufferLineInfoDiagnosticSelected = { bg = pallete.dark2, fg = pallete.bright_blue },
          BufferLineHintSelected = { bg = pallete.dark2, fg = pallete.bright_green, bold = true, italic = true },
          BufferLineHintDiagnosticSelected = { bg = pallete.dark2, fg = pallete.bright_green },
          BufferLinePickSelected = { bg = pallete.dark2, fg = pallete.bright_red, bold = true, italic = true },
          BufferLineDiagnosticSelected = { bg = pallete.dark2, fg = pallete.light1, bold = true, italic = true },
          BufferLineNumbersSelected = { bg = pallete.dark2, fg = pallete.light1, bold = true, italic = true },
          BufferLineTabSelected = { bg = pallete.dark2, fg = pallete.light1, bold = true, italic = true },

          BufferLineMiniIconsAzureSelected = { bg = pallete.dark2, fg = pallete.bright_blue },
          BufferLineMiniIconsBlueSelected = { bg = pallete.dark2, fg = pallete.bright_blue },
          BufferLineMiniIconsGreySelected = { bg = pallete.dark2, fg = pallete.light1 },
          BufferlineMiniIconsCyanSelected = { bg = pallete.dark2, fg = pallete.bright_aqua },
          BufferlineMiniIconsGreenSelected = { bg = pallete.dark2, fg = pallete.bright_green },
          BufferlineMiniIconsOrangeSelected = { bg = pallete.dark2, fg = pallete.bright_orange },
          BufferlineMiniIconsPurpleSelected = { bg = pallete.dark2, fg = pallete.bright_purple },
          BufferlineMiniIconsRedSelected = { bg = pallete.dark2, fg = pallete.bright_red },
          BufferlineMiniIconsYellowSelected = { bg = pallete.dark2, fg = pallete.bright_yellow },
        },
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
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = true,
      undercurl = true,
      overrides = function(c)
        local palette = c.palette
        local theme = c.theme
        local transparent = true
        local colors = {
          TelescopeResultsTitle = { fg = theme.ui.bg, bg = theme.ui.bg },
          TelescopePreviewTitle = { fg = theme.ui.bg, bg = theme.ui.bg },
          TelescopeTitle = { bg = theme.syn.special2, fg = theme.ui.bg },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
          TelescopeResultsBorder = { fg = theme.ui.bg, bg = theme.ui.bg },
          TelescopePreviewNormal = { bg = theme.ui.bg },
          TelescopePreviewBorder = { bg = theme.ui.bg, fg = theme.ui.bg },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          NeoTreeFloatTitle = { bg = theme.syn.special2, fg = theme.ui.bg },
          NeoTreeFloatBorder = { fg = theme.ui.bg, bg = theme.ui.bg },
          NeoTreeNormal = { bg = "NONE" },
          NeoTreeFloatNormal = { bg = theme.ui.bg },
          NeoTreeNormalNC = { bg = "NONE" },

          NoiceCmdlinePopup = { bg = theme.ui.bg },
          NoiceCmdlinePopupBorder = { fg = theme.ui.bg, bg = theme.ui.pg },
          NoiceCmdlinePopupTitle = { bg = theme.syn.special2, fg = theme.ui.bg },
          NoiceCmdlinePopupResults = { bg = theme.ui.bg_p1 },
          NoiceCmdlinePopupResultsBorder = { bg = theme.ui.bg_p1, fg = theme.ui.bg_p1 },
          NoiceMini = { bg = theme.ui.bg },

          FloatTitle = { bg = theme.syn.special2, fg = theme.ui.bg },
          FloatBorder = { fg = theme.ui.bg, bg = theme.ui.bg },
          NormalFloat = { bg = theme.ui.bg, blend = 0 },

          DiagnosticVirtualTextError = { bg = blend(theme.diag.error, theme.ui.bg, 0.1), fg = theme.diag.error },
          DiagnosticVirtualTextWarn = {
            bg = blend(theme.diag.warning, theme.ui.bg, 0.1),
            fg = theme.diag.warning,
          },
          DiagnosticVirtualTextInfo = { bg = blend(theme.diag.info, theme.ui.bg, 0.1), fg = theme.diag.info },
          DiagnosticVirtualTextHint = { bg = blend(theme.diag.hint, theme.ui.bg, 0.1), fg = theme.diag.hint },

          DiagnosticUnderlineError = { sp = theme.diag.error },
          DiagnosticUnderlineWarn = { sp = theme.diag.warning },
          DiagnosticUnderlineInfo = { sp = theme.diag.info },
          DiagnosticUnderlineHint = { sp = theme.diag.hint },

          WhichKeyFloat = { bg = theme.ui.bg_p1 },
          WhichKeyBorder = { bg = theme.ui.bg_p1 },
        }
        if transparent then
          colors.BufferLineSeparator = { fg = theme.ui.bg_m3 }
          colors.BufferLineSeparatorVisible = { fg = theme.ui.bg_m3 }
          colors.BufferLineSeparatorSelected = { fg = theme.ui.bg_m3 }
          colors.BufferLineFill = { bg = theme.ui.bg_m3 }
          colors.Visual = { bg = palette.waveBlue2 }
        end

        return colors
      end,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
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
