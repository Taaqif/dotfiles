return {
	on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
		
		local ts_utils_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")
		if ts_utils_ok then
			ts_utils.setup({})
			ts_utils.setup_client(client)
		end
	end,
}
