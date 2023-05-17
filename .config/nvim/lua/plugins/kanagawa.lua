local function hexToRgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

local blend = function(foreground, background, alpha)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = hexToRgb(background)
	local fg = hexToRgb(foreground)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

return {
	"rebelot/kanagawa.nvim",
	enabled = true,
	config = function()
		vim.o.background = "dark"

		local overrides = function(colors)
			local palette = colors.palette
			local theme = colors.theme
			return {
				TelescopeResultsTitle = { fg = theme.ui.bg, bg = theme.ui.bg },
				TelescopePreviewTitle = { fg = theme.ui.bg, bg = theme.ui.bg },
				TelescopeTitle = { bg = theme.syn.special2, fg = theme.ui.bg },
				TelescopePromptNormal = { bg = theme.ui.bg_p1 },
				TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
				TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
				TelescopeResultsBorder = { fg = theme.ui.bg, bg = theme.ui.bg },
				TelescopePreviewNormal = { bg = theme.ui.bg },
				TelescopePreviewBorder = { bg = theme.ui.bg, fg = theme.ui.bg },

				-- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg },
				-- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				-- PmenuSbar = { bg = theme.ui.bg_m1 },
				-- PmenuThumb = { bg = theme.ui.bg_p2 },

				NeoTreeFloatTitle = { bg = theme.syn.special2, fg = theme.ui.bg },
				NeoTreeFloatBorder = { fg = theme.ui.bg, bg = theme.ui.bg },
				NeoTreeNormal = { bg = theme.ui.bg },
				NeoTreeFloatNormal = { bg = theme.ui.bg },
				NeoTreeNormalNC = { bg = theme.ui.bg },

				FloatTitle = { bg = theme.syn.special2, fg = theme.ui.bg },
				FloatBorder = { fg = theme.ui.bg, bg = theme.ui.bg },
				NormalFloat = { bg = theme.ui.bg, blend = 0 },

				-- Nvim-Navic
				NavicIconsFile = { fg = palette.springViolet2 },
				NavicIconsModule = { fg = palette.boatYellow2 },
				NavicIconsNamespace = { fg = palette.springViolet2 },
				NavicIconsPackage = { fg = palette.springViolet1 },
				NavicIconsClass = { fg = palette.surimiOrange },
				NavicIconsMethod = { fg = palette.crystalBlue },
				NavicIconsProperty = { fg = palette.waveAqua2 },
				NavicIconsField = { fg = palette.waveAqua1 },
				NavicIconsConstructor = { fg = palette.surimiOrange },
				NavicIconsEnum = { fg = palette.boatYellow2 },
				NavicIconsInterface = { fg = palette.carpYellow },
				NavicIconsFunction = { fg = palette.crystalBlue },
				NavicIconsVariable = { fg = palette.oniViolet },
				NavicIconsConstant = { fg = palette.oniViolet },
				NavicIconsString = { fg = palette.springGreen },
				NavicIconsNumber = { fg = palette.sakuraPink },
				NavicIconsBoolean = { fg = palette.surimiOrange },
				NavicIconsArray = { fg = palette.waveAqua2 },
				NavicIconsObject = { fg = palette.surimiOrange },
				NavicIconsKey = { fg = palette.oniViolet },
				NavicIconsNull = { fg = palette.carpYellow },
				NavicIconsEnumMember = { fg = palette.carpYellow },
				NavicIconsStruct = { fg = palette.surimiOrange },
				NavicIconsEvent = { fg = palette.surimiOrange },
				NavicIconsOperator = { fg = palette.springViolet2 },
				NavicIconsTypeParameter = { fg = palette.springBlue },
				NavicText = { fg = palette.fujiWhite },
				NavicSeparator = { fg = palette.sumiInk4 },

				DiagnosticVirtualTextError = { bg = blend(theme.diag.error, theme.ui.bg, 0.1), fg = theme.diag.error },
				DiagnosticVirtualTextWarn = {
					bg = blend(theme.diag.warning, theme.ui.bg, 0.1),
					fg = theme.diag.warning,
				},
				DiagnosticVirtualTextInfo = { bg = blend(theme.diag.info, theme.ui.bg, 0.1), fg = theme.diag.info },
				DiagnosticVirtualTextHint = { bg = blend(theme.diag.hint, theme.ui.bg, 0.1), fg = theme.diag.hint },

				DiagnosticUnderlineError = { sp = theme.diag.error },
				DiagnosticUnderlineWarn = { sp = theme.diag.warning },
				DiagnosticUnderlineInfo = { sp = theme.diag.info },
				DiagnosticUnderlineHint = { sp = theme.diag.hint },

				WhichKeyFloat = { bg = theme.ui.pmenu.bg },
				WhichKeyBorder = { bg = theme.ui.pmenu.bg },
			}
		end
		require("kanagawa").setup({
			transparent = true,
			-- dimInactive = true,
			overrides = overrides,
			undercurl = false,
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
		})
		vim.cmd.colorscheme("kanagawa")
	end,
}
