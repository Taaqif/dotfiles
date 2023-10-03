local map = require("utils").keymap
return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "dmitmel/cmp-cmdline-history",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "rafamadriz/friendly-snippets",

      "L3MON4D3/LuaSnip",
    },
    config = function()
      local luasnip = require("luasnip")

      luasnip.filetype_extend("typescript", { "javascript" })
      luasnip.filetype_extend("typescriptreact", { "javascript" })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets/" })
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      local lspkind = require("lspkind")
      local icons = require("icons")

      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "luasnip" },
          { name = "path" },
          { name = "emoji" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            symbol_map = icons.kind,
            before = function(entry, vim_item) -- for tailwind css autocomplete
              if vim_item.kind == "Color" and entry.completion_item.documentation then
                local _, _, r, g, b =
                    string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
                if r then
                  local color = string.format("%02x", r)
                      .. string.format("%02x", g)
                      .. string.format("%02x", b)
                  local group = "Tw_" .. color
                  if vim.fn.hlID(group) < 1 then
                    vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
                  end
                  vim_item.kind_hl_group = group
                  return vim_item
                end
              end
              return vim_item
            end,
          }),
        },
        window = {
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -6,
          },
          documentation = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          },
        },
        mapping = {

          ["<C-e>"] = cmp.mapping({
            dj
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_next_item(),
          ["<C-f>"] = cmp.mapping.scroll_docs(5),
          ["<C-u>"] = cmp.mapping.scroll_docs(-5),
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-d>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        },
      })
      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        mapping = cmp.mapping.preset.cmdline(),
      })
      cmp.setup.cmdline("/", {
        sources = {
          { name = "nvim_lsp_document_symbol" },
          { name = "buffer" },
        },
        mapping = cmp.mapping.preset.cmdline(),
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
      { "jose-elias-alvarez/null-ls.nvim",
      }
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()
      local icons = require("icons")

      lsp_zero.on_attach(function(client, bufnr)
        map("n", "<leader>lf", function()
          vim.lsp.buf.format()
        end, { desc = "Format code", buffer = bufnr })
        map("n", "<leader>la", function()
          vim.lsp.buf.code_action()
        end, { desc = "LSP code action", buffer = bufnr })
        map("n", "<leader>lR", function()
          vim.lsp.buf.rename()
        end, { desc = "Rename current symbol", buffer = bufnr })

        map("n", "K", function()
          vim.lsp.buf.hover()
        end, { desc = "Hover symbol details", buffer = bufnr })
        map("n", "gd", function()
          vim.lsp.buf.definition()
        end, { desc = "Show the definition of current symbol", buffer = bufnr })
        map("n", "gr", function()
          vim.lsp.buf.references()
        end, { desc = "References of current symbol", buffer = bufnr })
        map("n", "gD", function()
          vim.lsp.buf.declaration()
        end, { desc = "Declaration of current symbol", buffer = bufnr })
        map("n", "gi", function()
          vim.lsp.buf.implementation()
        end, { desc = "Implementation of current symbol", buffer = bufnr })
        map("n", "<leader>ld", function()
          vim.diagnostic.open_float()
        end, { desc = "Hover diagnostics", buffer = bufnr })
        map("n", "[d", function()
          vim.diagnostic.goto_prev()
        end, { desc = "Previous diagnostic", buffer = bufnr })
        map("n", "[D", function()
          vim.diagnostic.goto_prev({
            severity = vim.diagnostic.severity.ERROR,
          })
        end, { desc = "Previous error diagnostic", buffer = bufnr })
        map("n", "]d", function()
          vim.diagnostic.goto_next()
        end, { desc = "Next diagnostic", buffer = bufnr })
        map("n", "]D", function()
          vim.diagnostic.goto_next({

            severity = vim.diagnostic.severity.ERROR,
          })
        end, { desc = "Next error diagnostic", buffer = bufnr })
        map("n", "gl", function()
          vim.diagnostic.open_float()
        end, { desc = "Hover diagnostics", buffer = bufnr })

        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
        end
      end)
      lsp_zero.set_sign_icons({
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warning,
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Information
      })
      vim.diagnostic.config({
        underline = true,
        virtual_text = {
          spacing = 5,
          prefix = "",
          severity_limit = "Warning",
          format = function(diagnostic)
            -- hide Info and hints from vtext
            if diagnostic.severity == vim.diagnostic.severity.INFO
                or diagnostic.severity == vim.diagnostic.severity.HINT
            then
              return nil
            else
              return diagnostic.message
            end
          end,
        },
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
      lsp_zero.set_server_config({
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true
            }
          }
        }
      })

      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })
      require("plugins.lsp.null_ls")
    end
  }
}
