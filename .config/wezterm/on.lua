local wezterm = require("wezterm")

local utils = require("utils")
local SOLID_LEFT_ARROW = ""
local SOLID_LEFT_MOST = "█"
local SOLID_RIGHT_ARROW = ""

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

	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		local hostname, cwd = utils.split_from_url(cwd_uri)
		table.insert(cells, cwd)
	end

	-- table.insert(cells, pane:get_title())

	local date = wezterm.strftime("%a %-d %b %I:%M %p ")
	table.insert(cells, date)
	local text = pane:get_domain_name()
	if text ~= "local" and text ~= "" then
		table.insert(cells, text)
	end

	local name = window:active_key_table()
	if name then
		name = "MODE: " .. name
		table.insert(cells, name)
	end

	local leader_is_active = window:leader_is_active()
	if leader_is_active then
		local leader = "LEADER"
		table.insert(cells, leader)
	end

	local elements = {}
	local num_cells = 0

	local right_status_colors = COLOR_CUSTOM.right_status

	local function push(text, is_last)
		local cell_no = num_cells + 1
		table.insert(elements, { Foreground = { Color = right_status_colors[cell_no].fg_color } })
		table.insert(elements, { Background = { Color = right_status_colors[cell_no].bg_color } })
		table.insert(elements, { Text = " " .. text .. " " })
		if not is_last then
			table.insert(elements, { Foreground = { Color = right_status_colors[cell_no + 1].bg_color } })
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
	local os_icon = tab.active_pane.user_vars.os_icon
	local id = ""
	if os_icon ~= nil then
		id = id .. " " .. os_icon .. " "
	else
		id = id .. " "
	end
	id = id .. tostring(tab.tab_index + 1) .. " "
	local left_arrow = SOLID_LEFT_ARROW
	if tab.tab_index == 0 then
		left_arrow = SOLID_LEFT_MOST
	end
	local background = COLOR.tab_bar.inactive_tab.bg_color
	local foreground = COLOR.tab_bar.inactive_tab.fg_color

	local has_unseen_output = false
	for _, pane in ipairs(tab.panes) do
		if pane.has_unseen_output then
			has_unseen_output = true
			break
		end
	end

	if has_unseen_output then
		background = COLOR_CUSTOM.tab_bar.unseen_tab.bg_color
		foreground = COLOR_CUSTOM.tab_bar.unseen_tab.fg_color
	end

	if tab.is_active then
		background = COLOR.tab_bar.active_tab.bg_color
		foreground = COLOR.tab_bar.active_tab.fg_color
		local is_copy_mode = string.find(tab.active_pane.title, "Copy mode:")
		if is_copy_mode then
			id = id .. "󰕢 "
			background = COLOR_CUSTOM.tab_bar.copy_mode.bg_color
			foreground = COLOR_CUSTOM.tab_bar.copy_mode.fg_color
		end
	elseif hover then
		background = COLOR_CUSTOM.tab_bar.hover_tab.bg_color
		foreground = COLOR_CUSTOM.tab_bar.hover_tab.fg_color
	end

	if tab.active_pane.is_zoomed then
		id = id .. "󰘖 "
	end

	local shell_icon = ""

	if tab.active_pane.title:find("nvim") then
		shell_icon = utf8.char(0xe62b)
	end

	if shell_icon ~= "" then
		id = id .. shell_icon .. " "
	end

	local no_of_panes = #tab.panes
	if no_of_panes > 1 then
		id = id .. SUP_IDX[no_of_panes]
	end

	local edge_foreground = background
	local edge_background = COLOR.tab_bar.background
	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = left_arrow },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = id },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Attribute = { Intensity = "Normal" } },
	}
end)
