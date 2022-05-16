local ok, treesitter_config = pcall(require, "nvim-treesitter.configs")

if not ok then
	return
end

treesitter_config.setup({
	-- ensure_installed = "all",
	highlight = 
		{
		enable = true,
	},
	indent = { enable = true },
	autopairs = { enable = true },
autotag = {
		enable = true,
	},
	matchup = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	rainbow = {
		enable = true,
	},
})
