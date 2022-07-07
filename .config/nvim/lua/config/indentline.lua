local ok, indent_blankline = pcall(require, "indent_blankline")

if not ok then
	return
end

vim.opt.list = true
vim.cmd [[highlight IndentBlanklineContextChar guifg=#E06C75 gui=nocombine]]

indent_blankline.setup({
	buftype_exclude = { "terminal" },
	-- char="▎",
	-- char = "▏",
	filetype_exclude = {
		"help",
		"terminal",
		"alpha",
		"packer",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"nvchad_cheatsheet",
		"lsp-installer",
		"NvimTree",
	},
	char_highlight_list = {
		-- "IndentBlanklineIndent1",
	},
	show_current_context = true,
	space_char_blankline = " ",
	use_treesitter = true,
	show_trailing_blankline_indent = false,
})
