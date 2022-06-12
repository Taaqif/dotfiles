local ok, null_ls = pcall(require, "null-ls")

if not ok then
	return
end

local completion = null_ls.builtins.completion
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {

		-- code action sources
		-- completion.spell,
		-- diagnostic sources
		diagnostics.cspell.with({
			diagnostics_postprocess = function(diagnostic)
				diagnostic.severity = vim.diagnostic.severity["INFO"]
			end,
			extra_args = { "--config", vim.fn.expand(vim.fn.stdpath("config") .. "/cspell.json" )},
			disabled_filetypes = { "NvimTree", "alpha", "toggleterm" },
			method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
		}),
		-- formatting sources
		formatting.stylua,
		formatting.prettierd,

		-- hover sources

		-- completion sources
	},
})
