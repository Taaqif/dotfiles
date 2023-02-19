local M = {}
_G.Status = M

---@return {name:string, text:string, texthl:string}[]
function M.get_signs()
	local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	return vim.tbl_map(function(sign)
		return vim.fn.sign_getdefined(sign.name)[1]
	end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
end

function M.column()
	local sign, git_sign
	for _, s in ipairs(M.get_signs()) do
		if s.name:find("GitSign") then
			git_sign = s
		else
			sign = s
		end
	end

	local nu = " "
	local number = vim.api.nvim_win_get_option(vim.g.statusline_winid, "number")
	if number and vim.wo.relativenumber and vim.v.virtnum == 0 then
		nu = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
	end
	local components = {
		sign and ("%#" .. sign.texthl .. "#" .. sign.text .. "%*") or " ",
		[[%=]],
		nu .. " ",
		git_sign and ("%#" .. git_sign.texthl .. "#" .. git_sign.text .. "%*") or "%#LineNr#▎ %*",
	}
	return table.concat(components, "")
end

if vim.fn.has("nvim-0.9.0") == 1 then
	vim.opt.statuscolumn = [[%!v:lua.Status.column()]]
	local ft_ignore = {
		"alpha",
		"neo-tree",
		"toggleterm",
		"TelescopePrompt",
		"Trouble",
		"Outline",
		"ToggleTerm",
		"help",
		"dap-repl",
		"dapui_scopes",
		"dapui_breakpoints",
		"dapui_stacks",
		"dapui_watches",
		"dapui_console",
	}
	local group = vim.api.nvim_create_augroup("StatusCol", { clear = true })
	vim.api.nvim_create_autocmd("FileType", { pattern = ft_ignore, group = group, command = "set statuscolumn=" })
end

return M
