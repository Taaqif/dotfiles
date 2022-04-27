local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  -- package_root = require("packer.util").join_paths(vim.fn.stdpath('data'), 'site', 'packer'),
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "rcarriga/nvim-notify"
  use "moll/vim-bbye"
  use "svermeulen/vim-cutlass"
  use {
    "lewis6991/impatient.nvim",
    config = function()
      require('impatient')
    end
  }
  use {
      "antoinemadec/FixCursorHold.nvim",
      config = function()
        vim.g.cursorhold_updatetime = 100
      end,
    }
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use {
    "numtostr/Comment.nvim",
    config = function()
      require("user.config._comment")
    end }
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require("nvim-web-devicons").setup()
    end
  }
  use {
    'akinsho/bufferline.nvim',
    config = function()
      require("user.config._bufferline")
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('user.config._lualine')
    end
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("user.config._whichkey")
    end
  }
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("user.config._nvimtree")
    end
  }
  use {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end
  }
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("user.config._indentline")
    end
  }
  -- cmp

  -- lsp
  use {
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer",
    "tamago324/nlsp-settings.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  }
  use {
      "MunifTanjim/prettier.nvim",
    config = function()
        require("prettier").setup({
        bin = 'prettier'})
        -- require("user.config._null_ls")
    end
}

  -- telescope
  use {
      {"nvim-telescope/telescope.nvim",
      config = function()
        require("user.config._telescope")
      end},
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {"nvim-telescope/telescope-fzf-native.nvim",run = 'make'},
      "nvim-telescope/telescope-file-browser.nvim",
  }
  -- treesitter
  use {
      {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
      config = function()
          require("user.config._treesitter")
      end
      },
        "JoosepAlviste/nvim-ts-context-commentstring",
        "p00f/nvim-ts-rainbow",
  }

  -- GIT
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("user.config._gitsigns")
    end
  }
  use "tpope/vim-fugitive"

  -- Terminal
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require("user.config._terminal")
    end,
  }

  --themes
  use "luisiacc/gruvbox-baby"
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
