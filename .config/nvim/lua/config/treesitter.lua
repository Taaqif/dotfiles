local ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
local treesitter_context_ok, treesitter_context = pcall(require, "treesitter-context")
if not ok then
	return
end

treesitter_config.setup({
	-- ensure_installed = "all",
	highlight = {
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

treesitter_context.setup{

}
