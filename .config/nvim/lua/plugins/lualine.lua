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

local show_lsp_names = false
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
	local icon = "  "
	if next(client_names) == nil then
		return icon .. "No LSP"
	else
		if show_lsp_names then
			return icon .. "[" .. table.concat(client_names, ",") .. "]"
		else
			return icon .. #client_names
		end
		-- return lsp_no .. " Clients"
	end
end

local function scrollbar()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
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

local function show_macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "recording @" .. recording_register
	end
end

function show_search_result()
	local res = vim.fn.searchcount({ maxcount = 0 })

	if res.total > 0 and vim.v.hlsearch ~= 0 then
		return string.format("/%s[%s/%d]", vim.fn.getreg("/"), res.current, res.total)
	else
		return ""
	end
end

return {
	"nvim-lualine/lualine.nvim",
	event = "BufWinEnter",
	config = function()
		local navic_ok, navic = pcall(require, "nvim-navic")
		local lualine = require("lualine")
		local colors = require("colors")

		lualine.setup({
			options = {
				theme = vim.g.colors_name or "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					"alpha",
					"NvimTree",
					"neo-tree",
					"packer",
					"toggleterm",
					"TelescopePrompt",
					"Trouble",
					"Outline",
					"help",
					"dap-repl",
					"dapui_scopes",
					"dapui_breakpoints",
					"dapui_stacks",
					"dapui_watches",
					"dapui_console",
				},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
					{
						"macro-recording",
						fmt = show_macro_recording,
						color = { fg = colors.orange },
					},
				},
				lualine_c = {},
				lualine_x = {
					{ show_search_result },
					"filetype",
				},
				lualine_y = {
					{
						"lsp-clients",
						fmt = lsp_client_names,
						on_click = function()
							show_lsp_names = not show_lsp_names
							lualine.refresh({
								place = { "statusline" },
							})
						end,
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
		})
		vim.api.nvim_create_autocmd("RecordingEnter", {
			callback = function()
				lualine.refresh({
					place = { "statusline" },
				})
			end,
		})

		vim.api.nvim_create_autocmd("RecordingLeave", {
			callback = function()
				-- This is going to seem really weird!
				-- Instead of just calling refresh we need to wait a moment because of the nature of
				-- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
				-- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
				-- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
				-- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
				local timer = vim.loop.new_timer()
				timer:start(
					50,
					0,
					vim.schedule_wrap(function()
						lualine.refresh({
							place = { "statusline" },
						})
					end)
				)
			end,
		})
	end,
}
