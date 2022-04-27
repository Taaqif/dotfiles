 local ts_config = require("nvim-treesitter.configs")

  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "lua",
      "vim",
   },
   highlight = {
      enable = true,
   },
   context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
    rainbow = {
		enable = true,
		colors = {
			"Gold",
			"Orchid",
			"DodgerBlue",
			-- "Cornsilk",
			-- "Salmon",
			-- "LawnGreen",
		},
		disable = { "html" },
	},
 }
