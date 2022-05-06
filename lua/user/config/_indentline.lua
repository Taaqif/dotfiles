local indent_blankline = require("indent_blankline")
vim.opt.list = true

indent_blankline.setup({
	-- show_end_of_line = true,
	-- space_char_blankline = " ",
	-- show_current_context_start = true,
	-- char_highlight_list = {
	--   "IndentBlanklineIndent1",
	--   "IndentBlanklineIndent2",
	--   "IndentBlanklineIndent3",
	-- },
	buftype_exclude = { "terminal" },
	-- char="▎",
	char = "▏",
	filetype_exclude = { "help", "NvimTree", "dashboard", "packer", "TelescopePrompt", "alpha" },
	show_current_context = true,
	space_char_blankline = " ",
	use_treesitter = true,
})
