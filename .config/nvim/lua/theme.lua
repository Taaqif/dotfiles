vim.opt.termguicolors = true

-- gruvbox baby
-- Enable telescope theme
-- vim.g.gruvbox_baby_telescope_theme = 1
-- vim.g.gruvbox_baby_transparent_mode = true

-- gruvbox material
-- vim.g.gruvbox_material_background = 'hard'
-- vim.g.gruvbox_material_palette = 'original'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_diagnostic_virtual_text = 1
vim.g.gruvbox_material_better_performance = 1
if vim.g.transparent_enabled then
	vim.g.gruvbox_material_transparent_background = 1
end
-- vim.cmd [[colorscheme gruvbox-material]]

--nightfox
local nightfox_ok, nightfox = pcall(require, "nightfox")

if nightfox_ok then
	nightfox.setup({
		options = {
			transparent = vim.g.transparent_enabled,
			styles = {
				comments = "italic",
				constants = "italic",
				keywords = "italic",
			},
		},
	})
end

--kanagawa
local kanagawa_ok, kanagawa = pcall(require, "kanagawa")

if kanagawa_ok then
	kanagawa.setup({
		transparent = vim.g.transparent_enabled,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { italic = true },
	})
end

--tokyonight
local tokyonight_ok, tokyonight = pcall(require, "tokyonight")

if tokyonight_ok then
	tokyonight.setup({
		transparent = vim.g.transparent_enabled,
	})
end

vim.cmd([[colorscheme gruvbox-material]])
-- vim.cmd([[colorscheme kanagawa]])

