local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")
local colors = require("colors")
local color_key = "kanagawa"
COLOR = colors[color_key]
COLOR_CUSTOM = colors[color_key .. "_custom"]

local keybinds = require("keybinds")
require("on")

local launch_menu = {}

local font_with_fallback = function(name, params)
	local names = { name, "JetBrains Mono" }
	return wezterm.font_with_fallback(names, params)
end

return {
	font_size = 11.0,
	check_for_updates = true,
	term = "xterm-256color",
	tab_bar_at_bottom = true,
	tab_bar_style = {
		window_maximize_hover = wezterm.format({
			{ Background = { Color = COLOR.tab_bar.active_tab.fg_color } },
			{ Foreground = { Color = COLOR.tab_bar.active_tab.bg_color } },
			{ Text = " " .. utils.icons.MAXIMIZE .. " " },
		}),
		window_close_hover = wezterm.format({
			{ Background = { Color = COLOR.tab_bar.active_tab.fg_color } },
			{ Foreground = { Color = COLOR.tab_bar.active_tab.bg_color } },
			{ Text = " " .. utils.icons.CLOSE .. " " },
		}),
		window_hide_hover = wezterm.format({
			{ Background = { Color = COLOR.tab_bar.active_tab.fg_color } },
			{ Foreground = { Color = COLOR.tab_bar.active_tab.bg_color } },
			{ Text = " " .. utils.icons.HIDE .. " " },
		}),
		window_maximize = wezterm.format({
			{ Background = { Color = COLOR.tab_bar.active_tab.bg_color } },
			{ Foreground = { Color = COLOR.tab_bar.active_tab.fg_color } },
			{ Text = " " .. utils.icons.MAXIMIZE .. " " },
		}),
		window_close = wezterm.format({
			{ Background = { Color = COLOR.tab_bar.active_tab.bg_color } },
			{ Foreground = { Color = COLOR.tab_bar.active_tab.fg_color } },
			{ Text = " " .. utils.icons.CLOSE .. " " },
		}),
		window_hide = wezterm.format({
			{ Background = { Color = COLOR.tab_bar.active_tab.bg_color } },
			{ Foreground = { Color = COLOR.tab_bar.active_tab.fg_color } },
			{ Text = " " .. utils.icons.HIDE .. " " },
		}),
		new_tab = wezterm.format({
			{ Text = "  " .. utils.icons.NEW .. " " },
		}),
		new_tab_hover = wezterm.format({
			{ Background = { Color = COLOR.tab_bar.active_tab.bg_color } },
			{ Foreground = { Color = COLOR.tab_bar.active_tab.fg_color } },
			{ Text = utils.icons.SOLID_RIGHT_ARROW },
			{ Text = " " .. utils.icons.NEW .. " " },
			{ Text = utils.icons.SOLID_LEFT_ARROW },
		}),
	},
	line_height = 1,
	-- default_domain = 'WSL:Ubuntu',
	default_prog = { "pwsh" },
	prefer_to_spawn_tabs = true,
	use_ime = true,
	initial_rows = 32,
	initial_cols = 120,
	font = font_with_fallback("Operator Mono SSm Lig Book", { style = "Normal" }),
	font_rules = {
		{
			italic = false,
			intensity = "Normal",
			font = font_with_fallback("Operator Mono SSm Lig Book", { style = "Normal" }),
		},
		{
			italic = true,
			intensity = "Normal",
			font = font_with_fallback("Operator Mono SSm Lig Book", { style = "Italic" }),
		},

		{
			italic = false,
			intensity = "Bold",
			font = font_with_fallback("Operator Mono SSm Lig Bold", { style = "Normal" }),
		},
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback("Operator Mono SSm Lig Bold", { style = "Italic" }),
		},
		{
			italic = false,
			intensity = "Half",
			font = font_with_fallback("Operator Mono SSm Lig Medium", { style = "Normal" }),
		},
		{
			italic = true,
			intensity = "Half",
			font = font_with_fallback("Operator Mono SSm Lig Medium", { style = "Italic" }),
		},
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 2,
		bottom = 0,
	},
	launch_menu = launch_menu,
	disable_default_key_bindings = true,
	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 },

	keys = keybinds.keybinds,
	key_tables = keybinds.key_tables,
	mouse_bindings = keybinds.mouse_bindings,

	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	},
	use_fancy_tab_bar = false,
	window_frame = {
		font = font_with_fallback("Operator Mono SSm Lig Book", { style = "Normal" }),
		font_size = 9.0,
	},
	-- enable_scroll_bar = true,
	-- window_background_opacity = 0.95,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	window_background_opacity = 0.6,
	win32_system_backdrop = "Acrylic",
	force_reverse_video_cursor = true,
	colors = COLOR,
	set_environment_variables = {
		VTE_VERSION = "6003",
	},
}
