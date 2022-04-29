local colors = {
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
local function list_registered_providers_names(filetype)
  local s = require "null-ls.sources"
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
	for _, client in ipairs(vim.lsp.get_active_clients()) do
		if client.name ~= "null-ls" then
			table.insert(client_names, client.name)
		end
	end
    local registered_providers = list_registered_providers_names(buf_ft)
    for method, sources in pairs(registered_providers) do
        for _, source in pairs(sources) do
            if(not has_value(client_names, source)) then
                table.insert(client_names, source)
            end
        end
    end
	return "[" .. table.concat(client_names, ",") .. "]"
end

local function scrollbar()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local config = {
	options = {
		icons_enabled = true,
		theme = vim.g.colors_name or "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "NvimTree", "packer", "toggleterm", "TelescopePrompt"  },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
		lualine_c = { "filename" },
		lualine_x = { "filetype" },
		lualine_y = { lsp_client_names },
		lualine_z = {
            {"location", separator = '', padding = { left = 0, right = 1 }},
			{ scrollbar, padding = { left = 0, right = 0 }, color = { fg = colors.yellow, bg = colors.bg }, seperator = '' },
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
	-- options = {
	-- 		theme = "gruvbox"
	-- }
}
require("lualine").setup(config)
