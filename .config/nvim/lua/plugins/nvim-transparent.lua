local M = {
  "xiyaowong/nvim-transparent",
  lazy = false
}

function M.config()
  require("transparent").setup({
    enable = true, 
    exclude = {
    }
  })
end

return M
