return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  config = function()
    vim.opt.list = true
    vim.cmd [[highlight IndentBlanklineContextChar guifg=#E06C75 gui=nocombine]]

    require("indent_blankline").setup({
      buftype_exclude = { "terminal" },
      -- char="▎",
      -- char = "▏",
      filetype_exclude = {
        "help",
        "terminal",
        "alpha",
        "packer",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "lsp-installer",
        "NvimTree",
        "mason",
        "neo-tree"
      },
      char_highlight_list = {
        -- "IndentBlanklineIndent1",
      },
      show_current_context = true,
      space_char_blankline = " ",
      use_treesitter = true,
      show_trailing_blankline_indent = false,
    })

  end
}
