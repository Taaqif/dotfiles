local ok, indent_blankline = pcall(require, "indent_blankline")

if not ok then
	return
end

vim.opt.list = true

indent_blankline.setup({
	buftype_exclude = { "terminal" },
	-- char="▎",
	char = "▏",
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
	},
	show_current_context = true,
	space_char_blankline = " ",
	use_treesitter = true,
	show_trailing_blankline_indent = false,
})
