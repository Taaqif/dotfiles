return {
	"monaqa/dial.nvim",
	init = function()
		local map = require("utils").keymap
		map("n", "<C-a>", function()
			return require("dial.map").inc_normal()
		end, { desc = "Increment", expr = true })
		map("n", "<C-x>", function()
			return require("dial.map").dec_normal()
		end, { desc = "Decrement", expr = true })
		map("v", "<C-a>", function()
			return require("dial.map").inc_visual()
		end, { desc = "Increment", expr = true })
		map("v", "<C-x>", function()
			return require("dial.map").dec_visual()
		end, { desc = "Decrement", expr = true })
		map("v", "g<C-a>", function()
			return require("dial.map").inc_gvisual()
		end, { desc = "Increment", expr = true })
		map("v", "g<C-x>", function()
			return require("dial.map").dec_gvisual()
		end, { desc = "Decrement", expr = true })
	end,
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal_int,
				augend.integer.alias.hex,
				augend.constant.alias.bool,
				augend.date.alias["%Y/%m/%d"],
				augend.constant.alias.alpha,
				augend.constant.alias.Alpha,
			},
		})
	end,
}
