local wezterm = require 'wezterm';
return {
  font_size = 11.0,
  color_scheme = "Gruvbox Dark",
  font_antialias = "Subpixel", -- None, Greyscale, Subpixel
  font_hinting = "Full", -- None, Vertical, VerticalSubpixel, Full
  font = wezterm.font("OperatorMonoSSmLig Nerd Font", { style = "Normal", weight = 325 }),
  default_prog = { "pwsh" },
  use_fancy_tab_bar = true,
  window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 0,
  },
}
