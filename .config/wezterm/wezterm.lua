local wezterm = require("wezterm")
local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})

	-- Find installed visual studio version(s) and add their compilation
	-- environment command prompts to the menu
	for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
		local year = vsvers:gsub("Microsoft Visual Studio/", "")
		table.insert(launch_menu, {
			label = "x64 Native Tools VS " .. year,
			args = {
				"cmd.exe",
				"/k",
				"C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat",
			},
		})
	end

	-- Enumerate any WSL distributions that are installed and add those to the menu
	local success, wsl_list, wsl_err = wezterm.run_child_process({ "wsl.exe", "-l" })
	-- `wsl.exe -l` has a bug where it always outputs utf16:
	-- https://github.com/microsoft/WSL/issues/4607
	-- So we get to convert it
	wsl_list = wezterm.utf16_to_utf8(wsl_list)

	for idx, line in ipairs(wezterm.split_by_newlines(wsl_list)) do
		-- Skip the first line of output; it's just a header
		if idx > 1 then
			-- Remove the "(Default)" marker from the default line to arrive
			-- at the distribution name on its own
			local distro = line:gsub(" %(Default%)", "")

			-- Add an entry that will spawn into the distro with the default shell
			table.insert(launch_menu, {
				label = distro .. " (WSL default shell)",
				args = { "wsl.exe", "--distribution", distro },
			})

			-- Here's how to jump directly into some other program; in this example
			-- its a shell that probably isn't the default, but it could also be
			-- any other program that you want to run in that environment
			table.insert(launch_menu, {
				label = distro .. " (WSL zsh login shell)",
				args = { "wsl.exe", "--distribution", distro, "--exec", "/bin/zsh", "-l" },
			})
		end
	end
end

wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%a %-d %b %H:%M ")

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.mdi_clock .. " " .. date },
	}))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	return "  " .. tab.tab_index + 1 .. "  "
end)

local font_with_fallback = function(name, params)
	local names = { name, "JetBrains Mono" }
	return wezterm.font_with_fallback(names, params)
end

return {
	font_size = 11.0,
	-- color_scheme = "Gruvbox Dark",
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
	keys = {
		{ key = "l", mods = "ALT", action = "ShowLauncher" },
		{ key = "`", mods = "ALT", action = wezterm.action{SpawnTab="CurrentPaneDomain"}},
		{ key = "1", mods = "ALT", action = wezterm.action{ActivateTab=0}},
		{ key = "2", mods = "ALT", action = wezterm.action{ActivateTab=1}},
		{ key = "3", mods = "ALT", action = wezterm.action{ActivateTab=2}},
		{ key = "4", mods = "ALT", action = wezterm.action{ActivateTab=3}},
		{ key = "5", mods = "ALT", action = wezterm.action{ActivateTab=4}},
		{ key = "6", mods = "ALT", action = wezterm.action{ActivateTab=5}},
		{ key = "7", mods = "ALT", action = wezterm.action{ActivateTab=6}},
		{ key = "8", mods = "ALT", action = wezterm.action{ActivateTab=7}},
		{ key = "9", mods = "ALT", action = wezterm.action{ActivateTab=8}},
	},
	use_fancy_tab_bar = false,
	-- window_background_opacity = 0.97,

	-- kanagawa.nvim
	force_reverse_video_cursor = true,
	colors = {
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
}
