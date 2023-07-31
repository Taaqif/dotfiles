return {
	"Darazaki/indent-o-matic",
	enabled = true,
	event = "BufReadPost",
	config = function()
		require("indent-o-matic").setup({})
	end,
}
