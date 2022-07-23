local function hi(group, opts)
	local c = "highlight " .. group
	for k, v in pairs(opts) do
		c = c .. " " .. k .. "=" .. v
	end
	vim.cmd(c)
end

hi('NonAscii', { guibg = "#333333" })
