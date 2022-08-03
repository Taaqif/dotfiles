local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

local keybinds = require("keybinds")
require("on")
local launch_menu = {}

local font_with_fallback = function(name, params)
	local names = { name, "JetBrains Mono" }
	return wezterm.font_with_fallback(names, params)
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
end
return {
	font_size = 10.0,
	check_for_updates = true,
	show_update_window = true,
	term = "xterm-256color",
	tab_bar_at_bottom = true,
	use_ime = true,
	initial_rows = 30,
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
	default_prog = { "pwsh" },
	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 0,
	},
	launch_menu = launch_menu,
	disable_default_key_bindings = true,
	-- leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },

	keys = keybinds.keybinds,
	key_tables = keybinds.key_tables,
	mouse_bindings = keybinds.mouse_bindings,

	use_fancy_tab_bar = false,
	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	},
	window_background_opacity = 0.97,
	-- enable_scroll_bar = true,
	window_decorations = "RESIZE",
	color_scheme = "gruvbox_material_dark_hard",
	color_schemes = {
		-- kanagawa.nvim
		["Kanagawa"] = {
			foreground = "#dcd7ba",
			background = "#1f1f28",

			cursor_bg = "#c8c093",
			cursor_fg = "#c8c093",
			cursor_border = "#c8c093",

			selection_fg = "#c8c093",
			selection_bg = "#2d4f67",

			scrollbar_thumb = "#16161d",
			split = "#16161d",

			ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
			brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
			indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
		},
		["gruvbox_material_dark_hard"] = {
			foreground = "#D4BE98",
			background = "#1D2021",
			cursor_bg = "#D4BE98",
			cursor_border = "#D4BE98",
			cursor_fg = "#1D2021",
			selection_bg = "#D4BE98",
			selection_fg = "#3C3836",

			ansi = { "#1d2021", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
			brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
		},
	},
}
