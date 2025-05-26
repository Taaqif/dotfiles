local wezterm = require("wezterm")

local M = {}

local font_with_fallback = function(name, params)
	local names = { name, "JetBrains Mono" }
	return wezterm.font_with_fallback(names, params)
end

function M.OperatorMono(config)
	config.font_size = 11.0
	config.font = font_with_fallback("Operator Mono SSm Lig Light", { style = "Normal" })

	config.font_rules = {
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
			font = font_with_fallback("Operator Mono SSm Lig Light", { style = "Normal" }),
		},
		{
			italic = true,
			intensity = "Half",
			font = font_with_fallback("Operator Mono SSm Lig Light", { style = "Italic" }),
		},
	}

	config.window_frame = {
		font = font_with_fallback("Operator Mono SSm Lig Book", { style = "Normal" }),
		font_size = 9.0,
	}
end

function M.Monaspace(config)
	config.font_size = 11.0
	config.font = font_with_fallback("MonaspiceNe NF", { style = "Normal" })

	config.font_rules = {
		{
			italic = false,
			intensity = "Normal",
			font = font_with_fallback("MonaspiceNe NF", { style = "Normal" }),
		},
		{
			italic = true,
			intensity = "Normal",
			font = font_with_fallback("MonaspiceNe NF Bold Italic", { style = "Italic" }),
		},
		{
			italic = false,
			intensity = "Bold",
			font = font_with_fallback("MonaspiceNe NF", { style = "Normal" }),
		},
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback("MonaspiceNe NF", { style = "Italic" }),
		},
		{
			italic = false,
			intensity = "Half",
			font = font_with_fallback("MonaspiceNe NF", { style = "Normal" }),
		},
		{
			italic = true,
			intensity = "Half",
			font = font_with_fallback("MonaspiceNe NF", { style = "Italic" }),
		},
	}

	config.window_frame = {
		font = font_with_fallback("MonaspiceNe NF", { style = "Normal" }),
		font_size = 9.0,
	}
end

function M.MonoLisa(config)
	config.font_size = 11.0
	config.font = font_with_fallback("MonoLisa-Regular", { style = "Normal" })

	config.font_rules = {
		{
			italic = false,
			intensity = "Normal",
			font = font_with_fallback("MonoLisa-Regular", { style = "Normal" }),
		},
		{
			italic = true,
			intensity = "Normal",
			font = font_with_fallback("MonoLisa-RegularItalic", { style = "Italic" }),
		},
		{
			italic = false,
			intensity = "Bold",
			font = font_with_fallback("MonoLisa-Bold", { style = "Normal" }),
		},
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback("MonoLisa-BoldItalic", { style = "Italic" }),
		},
		{
			italic = false,
			intensity = "Half",
			font = font_with_fallback("MonoLisa-Medium", { style = "Normal" }),
		},
		{
			italic = true,
			intensity = "Half",
			font = font_with_fallback("MonoLisa-MediumItalic", { style = "Italic" }),
		},
	}

	config.window_frame = {
		font = font_with_fallback("MonaspiceNe NF", { style = "Normal" }),
		font_size = 9.0,
	}
end

return M
