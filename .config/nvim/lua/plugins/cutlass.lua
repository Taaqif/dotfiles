return {
	"gbprod/cutlass.nvim",
	event = "VeryLazy",
	config = function()
		require("cutlass").setup({
			cut_key = "x",
			exclude = { "ns", "nS" },
		})
	end,
}
