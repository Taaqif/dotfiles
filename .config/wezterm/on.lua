local wezterm = require("wezterm")
local utils = require("utils")
local keybinds = require("keybinds")
local act = wezterm.action

local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local SUP_IDX = {
	"¹",
	"²",
	"³",
	"⁴",
	"⁵",
	"⁶",
	"⁷",
	"⁸",
	"⁹",
	"¹⁰",
	"¹¹",
	"¹²",
	"¹³",
	"¹⁴",
	"¹⁵",
	"¹⁶",
	"¹⁷",
	"¹⁸",
	"¹⁹",
	"²⁰",
}
local SUB_IDX = {
	"₁",
	"₂",
	"₃",
	"₄",
	"₅",
	"₆",
	"₇",
	"₈",
	"₉",
	"₁₀",
	"₁₁",
	"₁₂",
	"₁₃",
	"₁₄",
	"₁₅",
	"₁₆",
	"₁₇",
	"₁₈",
	"₁₉",
	"₂₀",
}

wezterm.on("update-right-status", function(window, pane)
	local cells = {}

	-- local cwd_uri = pane:get_current_working_dir()
	-- if cwd_uri then
	-- 	local hostname, cwd = utils.split_from_url(cwd_uri)
	-- 	table.insert(cells, cwd)
	-- end

	table.insert(cells, pane:get_title())

	local date = wezterm.strftime("%a %-d %b %I:%M %p ")
	table.insert(cells, date)
	local text = pane:get_domain_name()
	if text ~= "local" and text ~= "" then
		table.insert(cells, text)
	end
	
	local name = window:active_key_table()
	if name then
		name = "Mode: " .. name
		table.insert(cells, name)
	end
	-- Color palette for the backgrounds of each cell
	local colors = {
		"#2a2a37",
		-- "#E06C75",
		-- "#93474d",
		-- "#462224",
		"#7e9cd8",
		"#51648b",
		"#242c3e",
	}

	local text_colors = {
		"#b0b0b0",
		"#1C1B19",
		"#e7e7e7",
		"#fcfcfc",
	}

	local elements = {}
	local num_cells = 0

	local function push(text, is_last)
		local cell_no = num_cells + 1
		table.insert(elements, { Foreground = { Color = text_colors[cell_no] } })
		table.insert(elements, { Background = { Color = colors[cell_no] } })
		table.insert(elements, { Text = " " .. text .. " " })
		if not is_last then
			table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
			table.insert(elements, { Text = SOLID_LEFT_ARROW })
		end
		num_cells = num_cells + 1
	end
	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0)
	end

	window:set_right_status(wezterm.format(elements))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local id = " " .. tostring(tab.tab_index + 1) .. " "
	local left_arrow = SOLID_LEFT_ARROW
	if tab.tab_index == 0 then
		left_arrow = SOLID_LEFT_MOST
	end
	local edge_background = "#2a2a37"
	local background = "#595959"
	local foreground = "#b0b0b0"
	local dim_foreground = "#3A3A3A"

	local has_unseen_output = false
	for _, pane in ipairs(tab.panes) do
		if pane.has_unseen_output then
			has_unseen_output = true
			break
		end
	end

	if has_unseen_output then
		background = "#514545"
	end

	if tab.is_active then
		-- background = "#E06C75"
		background = "#7e9cd8"
		foreground = "#1C1B19"
		local is_copy_mode = string.find(tab.active_pane.title, "Copy mode:")
		if is_copy_mode then
			id = id .. "視 "
			-- background = "#ff9f65"
			background = "#e6c384"
		end
	elseif hover then
		-- background = "#E06C60"
		background = "#7e9cd8"
		foreground = "#1C1B19"
	end

	if tab.active_pane.is_zoomed then
		id = id .. "ﬕ "
	end

	local no_of_panes = #tab.panes
	if no_of_panes > 1 then
		id = id .. SUP_IDX[no_of_panes]
	end

	local edge_foreground = background
	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = left_arrow },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = id },
		{ Foreground = { Color = dim_foreground } },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Attribute = { Intensity = "Normal" } },
	}
end)
