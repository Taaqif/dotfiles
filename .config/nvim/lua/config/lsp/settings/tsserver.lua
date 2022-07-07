return {
	on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
-- 		local prettier_path = '.\\node_modules\\.bin\\prettier.cmd' -- default to local
-- local prettier_config = ' --config-precedence file-override --no-semi --use-tabs --single-quote'
-- -- use our own if project doesn't have
-- if vim.fn.executable(prettier_path) ~= 1 then
-- 	prettier_path = lsp_bins .. '\\node_modules\\.bin\\prettier.cmd'
-- end
		local ts_utils_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")
		if ts_utils_ok then
			ts_utils.setup({})
			ts_utils.setup_client(client)
		end
	end,
}
