return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "VeryLazy",
  init = function()
    -- vim.api.nvim_create_autocmd({ "FileType" }, {
    --   pattern = {
    --     "neo-tree",
    --   },
    --   callback = function()
    --     require("ufo").detach()
    --   end,
    -- })
  end,
  config = function()
    local ufo = require("ufo")
    vim.o.foldcolumn = "0"
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = -1
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })

    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = ("  %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end

    ufo.setup({
      fold_virt_text_handler = handler,
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })
  end,
}
