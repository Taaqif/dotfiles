local M = {}
local w = require("wezterm")
local act = w.action
local utils = require("utils")
local function is_vim(pane)
	-- this is set by the smart splits plugin, and unset on ExitPre in Neovim (https://github.com/mrjones2014/smart-splits.nvim)
	return pane:get_user_vars().IS_NVIM == "true"
end
local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "CTRL|SHIFT" or "CTRL",
		action = w.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "CTRL|SHIFT" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end
M.keybinds = {
	{
		key = " ",
		mods = "LEADER|CTRL",
		action = w.action.SendKey({
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
	{ key = "U", mods = "CTRL|SHIFT", action = act({ ScrollByPage = -0.5 }) },
	{ key = "D", mods = "CTRL|SHIFT", action = act({ ScrollByPage = 0.5 }) },
	{
		key = "P",
		mods = "CTRL",
		action = w.action.ActivateCommandPalette,
	},
	{
		key = "r",
		mods = "LEADER",
		action = act({
			ActivateKeyTable = {
				name = "resize_pane",
				one_shot = false,
				timeout_milliseconds = 3000,
				replace_current = false,
			},
		}),
	},
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
	{ key = "]", mods = "CTRL", action = act({ ActivateTabRelative = 1 }) },
	{ key = "[", mods = "CTRL", action = act({ ActivateTabRelative = -1 }) },
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

	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
}

M.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = act({ AdjustPaneSize = { "Left", 2 } }) },
		{ key = "h", action = act({ AdjustPaneSize = { "Left", 2 } }) },
		{ key = "RightArrow", action = act({ AdjustPaneSize = { "Right", 2 } }) },
		{ key = "l", action = act({ AdjustPaneSize = { "Right", 2 } }) },
		{ key = "UpArrow", action = act({ AdjustPaneSize = { "Up", 2 } }) },
		{ key = "k", action = act({ AdjustPaneSize = { "Up", 2 } }) },
		{ key = "DownArrow", action = act({ AdjustPaneSize = { "Down", 2 } }) },
		{ key = "j", action = act({ AdjustPaneSize = { "Down", 2 } }) },
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
	copy_mode = w.gui.default_key_tables().copy_mode,
	search_mode = w.gui.default_key_tables().search_mode,
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
