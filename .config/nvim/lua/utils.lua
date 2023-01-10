local M = { }

function M.keymap(mode, lhs, rhs, desc)
  if desc == nil or type(desc) == 'string' then 
    vim.keymap.set(mode, lhs, rhs, {
      noremap = true, 
      silent = true,
      desc = desc or nil
    })
  else
    local opts = desc
    if not opts.noremap then 
      opts.noremap = true
    end
    if not opts.silent then 
      opts.silent = true
    end
    vim.keymap.set(mode, lhs, rhs, opts)
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
