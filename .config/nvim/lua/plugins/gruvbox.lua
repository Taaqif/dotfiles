return {
	"sainnhe/gruvbox-material",
	lazy = false,
	dependencies = {
		"xiyaowong/nvim-transparent",
	},
	config = function()
		local colors = require("colors")
		local function hi(group, opts)
			local c = "highlight " .. group
			for k, v in pairs(opts) do
				c = c .. " " .. k .. "=" .. v
			end
			vim.cmd(c)
		end

		vim.g.gruvbox_material_enable_italic = 1
		vim.g.gruvbox_material_diagnostic_virtual_text = 1
		vim.g.gruvbox_material_better_performance = 1
		vim.g.gruvbox_material_transparent_background = 0

		vim.cmd.colorscheme("gruvbox-material")
		-- Telescope
		hi("TelescopeBorder", { guifg = colors.dark_black, guibg = colors.dark_black })
		hi("TelescopePromptBorder", { guifg = colors.black2, guibg = colors.black2 })
		hi("TelescopeResultsBorder", { guifg = colors.dark_black, guibg = colors.dark_black })
		hi("TelescopePreviewBorder", { guifg = colors.dark_black, guibg = colors.dark_black })

		hi("TelescopePromptNormal", { guifg = colors.white, guibg = colors.black2 })
		hi("TelescopePromptPrefix", { guifg = colors.red, guibg = colors.black2 })

		hi("TelescopeNormal", { guibg = colors.dark_black })

		hi("TelescopePreviewTitle", { guifg = colors.black })
		hi("TelescopePromptTitle", { guifg = colors.black, guibg = colors.red })
		hi("TelescopeResultsTitle", { guifg = colors.dark_black, guibg = colors.dark_black })

		hi("TelescopeSelection", { guibg = colors.black2 })
	end,
}
