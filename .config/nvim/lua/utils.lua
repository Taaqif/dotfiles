local M = { }

function M.keymap(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, {
    noremap = true, 
    silent = true,
    desc = desc or nil
  })
end

return M
