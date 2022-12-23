return {
	"gbprod/cutlass.nvim",
	config = function()
		require("cutlass").setup({
			cut_key = "x",
			exclude = { "ns", "nS" },
		})
	end,
}
