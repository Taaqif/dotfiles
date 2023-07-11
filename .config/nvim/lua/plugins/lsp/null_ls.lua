local ok, null_ls = pcall(require, "null-ls")

if not ok then
	return
end

local completion = null_ls.builtins.completion
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local config = {
	debug = false,
	sources = {

		-- diagnostics
		diagnostics.cspell.with({
			diagnostics_postprocess = function(diagnostic)
				diagnostic.severity = vim.diagnostic.severity.HINT
			end,
		}),
		-- formatting sources
		formatting.stylua,
		formatting.prettierd,

		-- hover sources

		-- completion sources
		code_actions.cspell.with({
			config = {
				find_json = function(params)
					return vim.fn.stdpath("config") .. "/cspell.json"
				end,
			},
		}),
	},
}

-- local typescript_ok, typescript = pcall(require, "typescript.extensions.null-ls.code-actions")
-- if typescript_ok then
-- 	table.insert(config.sources, typescript)
-- end

null_ls.setup(config)
