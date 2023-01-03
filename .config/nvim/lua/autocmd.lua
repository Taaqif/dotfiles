vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- highlight non ascii characters
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  command = [[syntax match NonAscii "[^\u0000-\u007F]"]],
})

