return {
	"monaqa/dial.nvim",
	init = function()
		local map = require("utils").keymap

		map("n", "<C-a>", function()
			require("dial.map").inc_normal()
		end, "Increment")
		map("n", "<C-x>", function()
			require("dial.map").dec_normal()
		end, "Decrement")
		map("v", "<C-a>", function()
			require("dial.map").inc_visual()
		end, "Increment")
		map("v", "<C-x>", function()
			require("dial.map").dec_visual()
		end, "Decrement")
		map("v", "g<C-a>", function()
			require("dial.map").inc_gvisual()
		end, "Increment")
		map("v", "g<C-x>", function()
			require("dial.map").dec_gvisual()
		end, "Decrement")
	end,
	event = "BufRead",
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
