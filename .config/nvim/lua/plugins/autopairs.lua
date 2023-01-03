return {
	"windwp/nvim-autopairs",
  event = "BufRead",
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim", "spectre_panel" },
		})
	end,
}
