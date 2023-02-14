return {
	"gbprod/cutlass.nvim",
	event = "BufRead",
	config = function()
		require("cutlass").setup({
			cut_key = "x",
			exclude = { "ns", "nS" },
		})
	end,
}
