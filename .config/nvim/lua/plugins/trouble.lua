local keymap = require("utils").keymap
local on_attach = require("utils").on_attach

return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup({
			use_diagnostic_signs = true,
		})
	end,
}
