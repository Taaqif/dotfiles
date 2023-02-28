local M = {}
local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

M.keybinds = {
	{
		key = " ",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({
			key = " ",
			mods = "CTRL",
		}),
	},
	{ key = "c", mods = "CTRL|SHIFT", action = act({ CopyTo = "Clipboard" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = act({ PasteFrom = "Clipboard" }) },
	{ key = "Insert", mods = "SHIFT", action = act({ PasteFrom = "PrimarySelection" }) },
	{ key = "=", mods = "CTRL", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL|SHIFT", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
	{ key = "x", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
	{ key = "PageUp", mods = "ALT", action = act({ ScrollByPage = -1 }) },
	{
		key = "P",
		mods = "CTRL",
		action = wezterm.action.ActivateCommandPalette,
	},
	{ key = "PageDown", mods = "ALT", action = act({ ScrollByPage = 1 }) },
	{
		key = "r",
		mods = "ALT",
		action = act({
			ActivateKeyTable = {
				name = "resize_pane",
				one_shot = false,
				timeout_milliseconds = 3000,
				replace_current = false,
			},
		}),
	},
	{ key = "k", mods = "ALT|CTRL", action = act.ActivateCopyMode },
	{ key = "j", mods = "ALT|CTRL", action = act({ PasteFrom = "PrimarySelection" }) },

	{ key = "n", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "q", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
	{ key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "1", mods = "LEADER", action = act({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = act({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = act({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = act({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = act({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = act({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = act({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = act({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = act({ ActivateTab = 8 }) },
	{ key = "]", mods = "LEADER", action = act({ ActivateTabRelative = 1 }) },
	{ key = "[", mods = "LEADER", action = act({ ActivateTabRelative = -1 }) },
	{ key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "H", mods = "LEADER", action = act({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "L", mods = "LEADER", action = act({ AdjustPaneSize = { "Right", 1 } }) },
	{ key = "K", mods = "LEADER", action = act({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "J", mods = "LEADER", action = act({ AdjustPaneSize = { "Down", 1 } }) },

	{ key = "Enter", mods = "ALT", action = "QuickSelect" },
	{ key = "/", mods = "ALT", action = act.Search("CurrentSelectionOrEmptyString") },
	{ key = "p", mods = "ALT", action = "ShowLauncher" },
}

M.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = act({ AdjustPaneSize = { "Left", 1 } }) },
		{ key = "h", action = act({ AdjustPaneSize = { "Left", 1 } }) },
		{ key = "RightArrow", action = act({ AdjustPaneSize = { "Right", 1 } }) },
		{ key = "l", action = act({ AdjustPaneSize = { "Right", 1 } }) },
		{ key = "UpArrow", action = act({ AdjustPaneSize = { "Up", 1 } }) },
		{ key = "k", action = act({ AdjustPaneSize = { "Up", 1 } }) },
		{ key = "DownArrow", action = act({ AdjustPaneSize = { "Down", 1 } }) },
		{ key = "j", action = act({ AdjustPaneSize = { "Down", 1 } }) },
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
	copy_mode = wezterm.gui.default_key_tables().copy_mode,
	search_mode = wezterm.gui.default_key_tables().search_mode,
}

M.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act({ CompleteSelection = "PrimarySelection" }),
	},
	{
		event = { Up = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act({ CompleteSelection = "Clipboard" }),
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = "OpenLinkAtMouseCursor",
	},
}

return M
