local colors = require("colors")
return {
	"rebelot/kanagawa.nvim",
	config = function()
		vim.o.background = "dark"
		local c = require("kanagawa.color")
		local default_colors = require("kanagawa.colors").setup()

		local overrides = {
			-- Nvim-Navic
			NavicIconsFile = { fg = default_colors.springViolet2 },
			NavicIconsModule = { fg = default_colors.boatYellow2 },
			NavicIconsNamespace = { fg = default_colors.springViolet2 },
			NavicIconsPackage = { fg = default_colors.springViolet1 },
			NavicIconsClass = { fg = default_colors.surimiOrange },
			NavicIconsMethod = { fg = default_colors.crystalBlue },
			NavicIconsProperty = { fg = default_colors.waveAqua2 },
			NavicIconsField = { fg = default_colors.waveAqua1 },
			NavicIconsConstructor = { fg = default_colors.surimiOrange },
			NavicIconsEnum = { fg = default_colors.boatYellow2 },
			NavicIconsInterface = { fg = default_colors.carpYellow },
			NavicIconsFunction = { fg = default_colors.crystalBlue },
			NavicIconsVariable = { fg = default_colors.oniViolet },
			NavicIconsConstant = { fg = default_colors.oniViolet },
			NavicIconsString = { fg = default_colors.springGreen },
			NavicIconsNumber = { fg = default_colors.sakuraPink },
			NavicIconsBoolean = { fg = default_colors.surimiOrange },
			NavicIconsArray = { fg = default_colors.waveAqua2 },
			NavicIconsObject = { fg = default_colors.surimiOrange },
			NavicIconsKey = { fg = default_colors.oniViolet },
			NavicIconsNull = { fg = default_colors.carpYellow },
			NavicIconsEnumMember = { fg = default_colors.carpYellow },
			NavicIconsStruct = { fg = default_colors.surimiOrange },
			NavicIconsEvent = { fg = default_colors.surimiOrange },
			NavicIconsOperator = { fg = default_colors.springViolet2 },
			NavicIconsTypeParameter = { fg = default_colors.springBlue },
			NavicText = { fg = default_colors.fujiWhite },
			NavicSeparator = { fg = default_colors.sumiInk4 },

			-- Telescope
			TelescopeBorder = { fg = default_colors.sumiInk0, bg = default_colors.sumiInk0 },
			TelescopePromptBorder = { fg = default_colors.sumiInk2, bg = default_colors.sumiInk2 },
			TelescopeResultsBorder = { fg = default_colors.sumiInk0, bg = default_colors.sumiInk0 },
			TelescopePreviewBorder = { fg = default_colors.sumiInk0, bg = default_colors.sumiInk0 },
			TelescopePromptNormal = { fg = colors.white, bg = default_colors.sumiInk2 },
			TelescopePromptPrefix = { fg = default_colors.waveRed, bg = default_colors.sumiInk2 },
			TelescopeNormal = { bg = default_colors.sumiInk0 },
			TelescopePreviewTitle = { fg = colors.sumiInk0 },
			TelescopePromptTitle = { fg = colors.black, bg = default_colors.waveRed },
			TelescopeResultsTitle = { fg = default_colors.sumiInk0, bg = default_colors.sumiInk0 },
			TelescopeSelection = { bg = default_colors.sumiInk2 },

			--Neotree
			NeoTreeFloatTitle = { fg = colors.black, bg = default_colors.waveRed },
			NeoTreeFloatBorder = { fg = default_colors.sumiInk0, bg = default_colors.sumiInk0 },
			NeoTreeNormal = { bg = default_colors.sumiInk0 },
			NeoTreeNormalNC = { bg = default_colors.sumiInk0 },

			--TSRainbow
			rainbowcol1 = { fg = default_colors.waveRed },

			-- Diagnostics
			-- DiagnosticError = { bg = tostring(c(default_colors.samuraiRed):lighten(0.1)) },
			-- DiagnosticWarn = { bg = default_colors.roninYellow},
			-- DiagnosticInfo = { bg = default_colors.dragonBlue },
			-- DiagnosticHint = { bg = default_colors.waveAqua1 },

      -- Float
			FloatTitle = { fg = colors.black, bg = default_colors.waveRed },
			FloatBorder = { fg = default_colors.sumiInk0, bg = default_colors.sumiInk0 },
			NormalFloat = { bg = default_colors.sumiInk0 },
		}
		require("kanagawa").setup({
			transparent = false,
			overrides = overrides,
		})
		vim.cmd.colorscheme("kanagawa")
	end,
}
