return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "twig" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        twiggy_language_server = {
          enabled = true,
        },
      },
    },
  },
}
