local wezterm = require("wezterm")
local is_apple = wezterm.target_triple:find("apple") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil
local is_windows = wezterm.target_triple:find("windows") ~= nil
local utils = require("utils")
local colors = require("colors")
local keybinds = require("keybinds")
local fonts = require("fonts")

require("events")

local config = wezterm.config_builder()

local color_key = "kanagawa"
COLOR = colors[color_key]
COLOR_CUSTOM = colors[color_key .. "_custom"]

config.font_size = 11.0
config.check_for_updates = true
config.term = "xterm-256color"
config.tab_bar_at_bottom = true
config.tab_bar_style = {
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
		{ Background = { Color = "NONE" } },
		{ Foreground = { Color = COLOR.tab_bar.active_tab.bg_color } },
		{ Text = "  " .. utils.icons.NEW .. "  " },
	}),
}
config.line_height = 1
config.prefer_to_spawn_tabs = true
config.use_ime = true
config.initial_rows = 32
config.initial_cols = 120

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.launch_menu = {}
config.disable_default_key_bindings = true
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keybinds.keybinds
config.key_tables = keybinds.key_tables
config.mouse_bindings = keybinds.mouse_bindings

config.visual_bell = {
	fade_in_duration_ms = 75,
	fade_out_duration_ms = 75,
	target = "CursorColor",
}

config.use_fancy_tab_bar = false
config.force_reverse_video_cursor = true
config.colors = COLOR
config.set_environment_variables = {
	VTE_VERSION = "6003",
}

if is_windows then
	config.window_background_opacity = 0
	config.default_prog = { "pwsh" }
	config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
	config.win32_system_backdrop = "Mica"
elseif is_apple then
	config.window_decorations = "RESIZE"
	config.window_background_opacity = 0.5
	config.macos_window_background_blur = 100
end

fonts.OperatorMono(config)

return config
