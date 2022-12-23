return {
	"gbprod/cutlass.nvim",
	lazy = false,
	config = function()
		require("cutlass").setup({
			cut_key = "x",
			exclude = { "ns", "nS" },
		})
	end,
}
