return {
	"dnlhc/glance.nvim",
	cmd = "Glance",
	config = function()
		local glance = require("glance")
		local actions = glance.actions
		glance.setup({
			height = height,
			mappings = {
				list = {
					["l"] = actions.jump,
				},
			},
			hooks = {
				before_open = function(results, open, jump, method)
					--Don't open glance when there is only one result instead jump to that location
					if #results == 1 then
						jump(results[1])
					else
						open(results)
					end
				end,
				after_close = function()
				end,
			},
		})
	end,
}
