local map = require("utils").keymap
return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" },             -- Required
    { "williamboman/mason.nvim" },           -- Optional
    { "williamboman/mason-lspconfig.nvim" }, -- Optional

    -- Autocompletion
    { "hrsh7th/nvim-cmp" },     -- Required
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "L3MON4D3/LuaSnip" },     -- Required
    "b0o/schemastore.nvim",
  },
  event = "BufRead",
  init = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>l"] = { name = "LSP" },
    })
  end,
  config = function()
    local icons = require("icons")
    local signs = {
      { name = "DiagnosticSignError", text = icons.diagnostics.Error },
      { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
      { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
      { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
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
      update_in_insert = true,
      signs = {
        active = signs,
      },
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
    local lsp = require("lsp-zero").preset({})

    lsp.on_attach(function(client, bufnr)
      local illuminate_ok, illuminate = pcall(require, "illuminate")
      local navic_ok, navic = pcall(require, "nvim-navic")
      local enable_trouble = false
      local enable_glance = true


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

      if enable_trouble then
        map("n", "<leader>ll", ":TroubleToggle<CR>", { desc = "Trouble document Diagnostics", buffer = bufnr })
        map("n", "gd", ":Trouble lsp_definitions<CR>", { desc = "Goto Definition", buffer = bufnr })
        map("n", "gr", ":Trouble lsp_references<CR>", { desc = "References", buffer = bufnr })
        map("n", "gD", ":Trouble lsp_declarations<CR>", { desc = "Goto Declaration", buffer = bufnr })
        map("n", "gi", ":Trouble lsp_implementations<CR>", { desc = "Goto Implementation", buffer = bufnr })
        map("n", "gt", ":Trouble lsp_type_definitions<CR>", { desc = "Goto Type Definition", buffer = bufnr })
      elseif enable_glance then
        map("n", "gd", ":Glance definitions<CR>", { desc = "Glance the definition of current symbol", buffer = bufnr })
        map("n", "gr", ":Glance references<CR>", { desc = "Glance the references of current symbol", buffer = bufnr })
        map(
          "n",
          "gi",
          ":Glance implementations<CR>",
          { desc = "Glance the implementation of current symbol", buffer = bufnr }
        )
        map(
          "n",
          "gt",
          ":Glance type_definitions<CR>",
          { desc = "Glance the Type Definitions of current symbol", buffer = bufnr }
        )
      else
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
      end

      map({ "n", "i" }, "<C-k>", function()
        vim.lsp.buf.signature_help()
      end, { desc = "Show signature help", buffer = bufnr })
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


      if illuminate_ok then
        illuminate.on_attach(client)
      end

      if navic_ok and client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end

      lsp.default_keymaps({ buffer = bufnr })
    end)

    -- (Optional) Configure lua language server for neovim
    require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()
  end,
}
--
--
-- local M = {
-- 	"neovim/nvim-lspconfig",
-- 	dependencies = {
-- 		"williamboman/mason.nvim",
-- 		"williamboman/mason-lspconfig.nvim",
-- 		"neovim/nvim-lspconfig",
-- 		"nvim-lua/lsp-status.nvim",
-- 		"b0o/schemastore.nvim",
-- 		"SmiteshP/nvim-navic",
-- 		"RRethy/vim-illuminate",
-- 		"RishabhRD/nvim-lsputils",
-- 		"jose-elias-alvarez/null-ls.nvim",
-- 		-- typescript
-- 		"jose-elias-alvarez/typescript.nvim",
-- 		--rust
-- 		"simrat39/rust-tools.nvim",
-- 	},
-- 	event = "BufRead",
-- 	init = function()
-- 		local wk = require("which-key")
-- 		wk.register({
-- 			["<leader>l"] = { name = "LSP" },
-- 		})
-- 	end,
-- }
--
-- function M.config()
-- 	local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
-- 	local mason_lspconfig = require("mason-lspconfig")
--
-- 	local navic_ok, navic = pcall(require, "nvim-navic")
--
-- 	if navic_ok then
-- 		vim.g.navic_silence = true
-- 		navic.setup({
-- 			highlight = true,
-- 			separator = "  ",
-- 		})
-- 	end
--
-- 	local util = lspconfig.util
-- 	mason_lspconfig.setup({})
--
-- 	require("plugins.lsp.null_ls")
-- 	local icons = require("icons")
-- 	local signs = {
-- 		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
-- 		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
-- 		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
-- 		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
-- 	}
--
-- 	for _, sign in ipairs(signs) do
-- 		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
-- 	end
--
-- 	vim.diagnostic.config({
-- 		underline = true,
-- 		virtual_text = {
-- 			spacing = 5,
-- 			prefix = "",
-- 			severity_limit = "Warning",
-- 			format = function(diagnostic)
-- 				-- hide Info and hints from vtext
-- 				if diagnostic.severity == vim.diagnostic.severity.INFO
-- 						or diagnostic.severity == vim.diagnostic.severity.HINT
-- 				then
-- 					return nil
-- 				else
-- 					return diagnostic.message
-- 				end
-- 			end,
-- 		},
-- 		update_in_insert = false,
-- 		signs = {
-- 			active = signs,
-- 		},
-- 		severity_sort = true,
-- 		float = {
-- 			focusable = false,
-- 			style = "minimal",
-- 			border = "rounded",
-- 			source = "always",
-- 			header = "",
-- 			prefix = "",
-- 		},
-- 	})
--
-- 	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
-- 		border = "rounded",
-- 	})
--
-- 	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
-- 		border = "rounded",
-- 	})
--
-- 	local servers = {}
--
-- 	for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
-- 		table.insert(servers, server)
-- 	end
-- 	for _, server in ipairs(servers) do
-- 		local status_ok, server_opts = pcall(require, "plugins.lsp.settings." .. server)
-- 		local opts = {
-- 			capabilities = require("plugins.lsp.handlers").capabilities,
-- 		}
-- 		if status_ok then
-- 			opts = vim.tbl_deep_extend("force", server_opts, opts)
-- 			opts["setup"] = nil
-- 		end
-- 		opts.on_attach = function(client, bufnr)
-- 			require("plugins.lsp.handlers").on_attach(client, bufnr)
-- 			if status_ok and type(server_opts.on_attach) == "function" then
-- 				server_opts.on_attach(client, bufnr)
-- 			end
-- 		end
-- 		if status_ok and type(server_opts.setup) == "function" then
-- 			server_opts.setup(opts)
-- 		else
-- 			lspconfig[server].setup(opts)
-- 		end
-- 	end
-- end
--
-- return M
