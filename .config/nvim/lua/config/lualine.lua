local ok, lualine = pcall(require, "lualine")
local lsp_format_ok, lsp_format = pcall(require, "lsp-format")
local navic_ok, navic = pcall(require, "nvim-navic")
if not ok then
	return
end

local colors = {
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}
local function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local function list_registered_providers_names(filetype)
	local s = require("null-ls.sources")
	local available_sources = s.get_available(filetype)
	local registered = {}
	for _, source in ipairs(available_sources) do
		for method in pairs(source.methods) do
			registered[method] = registered[method] or {}
			table.insert(registered[method], source.name)
		end
	end
	return registered
end

local function lsp_client_names()
	local client_names = {}
	local buf_ft = vim.bo.filetype
	local lsp_no = 0
	for _, client in ipairs(vim.lsp.get_active_clients()) do
		if client.name ~= "null-ls" then
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				table.insert(client_names, client.name)
				lsp_no = lsp_no + 1
			end
		end
	end
	local registered_providers = list_registered_providers_names(buf_ft)
	for method, sources in pairs(registered_providers) do
		for _, source in pairs(sources) do
			if not has_value(client_names, source) then
				if source ~= "cspell" then
					table.insert(client_names, source)
					lsp_no = lsp_no + 1
				end
			end
		end
	end
	-- add in auto fomat indicator
	if next(client_names) == nil then
		return "No LSP"
	else
		return "[" .. table.concat(client_names, ",") .. "]"
		-- return lsp_no .. " Clients"
	end
end

local function scrollbar()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local function tab_space_width()
	if not vim.api.nvim_buf_get_option(0, "expandtab") then
		return "TAB:" .. vim.api.nvim_buf_get_option(0, "tabstop")
	end
	local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
	if size == 0 then
		size = vim.api.nvim_buf_get_option(0, "tabstop")
	end
	return "SPC:" .. size
end

local function display_lsp_status()
	-- if #vim.lsp.buf_get_clients() == 0 then return '' end
	local status = require("lsp-status").status()
	if status == "" then
		return ""
	end
	status = string.gsub(status, "%(", "") -- get rid of opening paren
	status = string.gsub(status, "ʪ ", "") -- get rid of ls symbol so we can add it on a lualine component level
	status = string.gsub(status, "%)", "") -- get rid of closing paren
	status = string.gsub(status, "^%s*(.-)%s*$", "%1") -- trim

	return status
end

local function display_treesitter_status()
	local b = vim.api.nvim_get_current_buf()
	if next(vim.treesitter.highlighter.active[b]) then
		return ""
	end
	return ""
end

local function autoformat_status()
	if lsp_format_ok and not lsp_format.disabled then
		return ""
	else
		return ""
	end
end

local gstatus = { ahead = 0, behind = 0 }
local function update_gstatus()
	local Job = require("plenary.job")
	Job:new({
		command = "git",
		args = { "rev-list", "--left-right", "--count", "HEAD...@{upstream}" },
		on_exit = function(job, _)
			local res = job:result()[1]
			if type(res) ~= "string" then
				gstatus = { ahead = 0, behind = 0 }
				return
			end
			local ok, ahead, behind = pcall(string.match, res, "(%d+)%s*(%d+)")
			if not ok then
				ahead, behind = 0, 0
			end
			gstatus = { ahead = ahead, behind = behind }
		end,
	}):start()
end

-- if _G.Gstatus_timer == nil then
-- 	_G.Gstatus_timer = vim.loop.new_timer()
-- else
-- 	_G.Gstatus_timer:stop()
-- end
-- _G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))
--
-- local display_gstatus_ = function()
-- 	if gstatus.ahead > 0 or gstatus > 0 then
-- 		return gstatus.ahead .. " " .. gstatus.behind .. ""
-- 	else
-- 		return ""
-- 	end
-- end

local config = {
	options = {
		icons_enabled = true,
		-- theme = "gruvbox",
		theme = vim.g.colors_name or "auto",
		-- section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		-- component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "NvimTree", "packer", "toggleterm", "TelescopePrompt" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			"diff",
			-- { display_gstatus_ },
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				-- sections = { 'error', 'warn', 'info', 'hint' },
				diagnostics_color = {
					-- Same values as the general color option can be used here.
					error = { fg = colors.red }, -- Changes diagnostics' error color.
					warn = { fg = colors.yellow }, -- Changes diagnostics' warn color.
					info = { fg = colors.blue }, -- Changes diagnostics' info color.
					hint = { fg = colors.green }, -- Changes diagnostics' hint color.
				},
				colored = true,
			},
		},
		lualine_c = { "filename" },
		lualine_x = {
			"filetype",
		},
		lualine_y = {
			{
				lsp_client_names,
				icon = "ʪ",
			},
			{
				autoformat_status,
				separator = "",
				padding = { left = 1, right = 1 },
			},
		},
		lualine_z = {
			{ "location", separator = "", padding = { left = 0, right = 1 } },
			{ tab_space_width, separator = "", padding = { left = 0, right = 1 } },
			{
				scrollbar,
				padding = { left = 0, right = 0 },
				color = { fg = colors.yellow, bg = colors.bg },
				separator = "",
			},
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
	winbar = {
		lualine_a = {},
		lualine_b = {
			"filename",
		},
		lualine_c = {
			{
				navic.get_location,
				cond = navic_ok and navic.is_available,
			},
		},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
}
lualine.setup(config)
