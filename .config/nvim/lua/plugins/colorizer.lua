return {
  "norcalli/nvim-colorizer.lua",

  event = "BufRead",
  config = function()
    require 'colorizer'.setup({
      "css",
      "lua",
      "scss",
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
    }, {
        RGB = true, 
        RRGGBB = true, 
        names = true, 
        RRGGBBAA = true, 
        rgb_fn = true, 
        hsl_fn = true, 
        css = true, 
        css_fn = false, 
        mode = "background", 
      })
  end
}
