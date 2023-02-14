return {
	"Darazaki/indent-o-matic",
	event = "BufRead",
	config = function()
		require("indent-o-matic").setup({})
	end,
}
