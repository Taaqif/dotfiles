local typescript_ok, typescript = pcall(require, "typescript")
local _, lspconfig = pcall(require, "lspconfig")
return {
	setup = function (opts)
		if typescript_ok then 
			typescript.setup({
				server = opts
			})
		else
			lspconfig["tsserver"].setup(opts)
		end
	end,
	on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
-- 		local prettier_path = '.\\node_modules\\.bin\\prettier.cmd' -- default to local
-- local prettier_config = ' --config-precedence file-override --no-semi --use-tabs --single-quote'
-- -- use our own if project doesn't have
-- if vim.fn.executable(prettier_path) ~= 1 then
-- 	prettier_path = lsp_bins .. '\\node_modules\\.bin\\prettier.cmd'
-- end
	end,
}
