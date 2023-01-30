local M = {}

function M.keymap(mode, lhs, rhs, opts)
	if opts == nil or type(opts) == "string" then
		vim.keymap.set(mode, lhs, rhs, {
			noremap = true,
			silent = true,
			desc = opts or nil,
		})
	else
		local options = { noremap = true, silent = true }
		if opts then
			options = vim.tbl_extend("force", options, opts)
		end
		vim.keymap.set(mode, lhs, rhs, options)
	end
end

function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

return M
