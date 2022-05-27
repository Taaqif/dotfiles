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
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	return "  " .. tab.tab_index + 1 .. "  "
end)
return {
	font_size = 11.0,
	color_scheme = "Gruvbox Dark",
	font = wezterm.font_with_fallback({
		{ family = "OperatorMonoSSmLig Nerd Font", weight = 325, stretch = "Normal", style = "Normal" },
		{ family = "OperatorMonoSSmLig Nerd Font", weight = 325, stretch = "Normal", style = "Italic" },
	}),
	default_prog = { "pwsh" },
	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 0,
	},
	launch_menu = launch_menu,
  font_antialias = "Greyscale", -- None, Greyscale, Subpixel
  font_hinting = "Full", -- None, Vertical, VerticalSubpixel, Full
	keys = {
		{ key = "l", mods = "ALT", action = "ShowLauncher" },
	},
	use_fancy_tab_bar = false,
	window_background_opacity = 0.97,
}
