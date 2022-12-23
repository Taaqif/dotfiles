local colors = require("colors")

local function hi(group, opts)
	local c = "highlight " .. group
	for k, v in pairs(opts) do
		c = c .. " " .. k .. "=" .. v
	end
	vim.cmd(c)
end

hi('NonAscii', { guibg = "#333333" })
hi('CurrentWord', { gui = "NONE", cterm="NONE", term = "NONE", guibg = "#444444" })

-- Custom ui
-- hi("Pmenu", { guifg = colors.white, guibg = colors.dark_black })

