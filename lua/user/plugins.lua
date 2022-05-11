local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	-- package_root = require("packer.util").join_paths(vim.fn.stdpath('data'), 'site', 'packer'),
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})
local function configure(name)
	return require(string.format("user.config.%s", name))
end

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end,
	})
	use({
		"Darazaki/indent-o-matic",
		config = function()
			require("indent-o-matic").setup({})
		end,
	})
	use({
		"goolord/alpha-nvim",
		config = function()
			require("user.config._alpha")
		end,
	})
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("tpope/vim-surround")
	use("mg979/vim-visual-multi")
	use("tpope/vim-repeat")
	use("AndrewRadev/switch.vim")
	use({
		"rcarriga/nvim-notify",
		config = function()
			local _notify = require("notify")
			_notify.setup({
				-- Minimum level to show
				level = "info",

				-- Animation style (see besuuslow for details)
				stages = "fade_in_slide_out",
			})
			vim.notify = _notify
		end,
	})
	use("moll/vim-bbye")
	use("svermeulen/vim-cutlass") 
	use({
		"windwp/nvim-spectre",
		config = function()
			require("spectre").setup({})
		end,
	})
	use({
		"filipdutescu/renamer.nvim",
		config = function()
			require("renamer").setup({})
		end,
	})
	use({
		"antoinemadec/FixCursorHold.nvim",
		config = function() end,
	})
	use({
		"numtostr/Comment.nvim",
		config = function()
			require("user.config._comment")
		end,
	})
	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("user.config._bufferline")
		end,
	})
	use({
		"windwp/nvim-autopairs",
		config = function() 
			require('nvim-autopairs').setup({
				disable_filetype = { "TelescopePrompt" , "vim" },
			})
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		config = function() end,
	})
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
		end,
	})
	-- use({
	-- 	"github/copilot.vim",
	-- 	config = function() end,
	-- })
	use({
		"folke/which-key.nvim",
		config = function()
			require("user.config._whichkey")
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("user.config._nvimtree")
		end,
	})
	use({
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	})
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"css",
				"javascript",
				"scss",
				"lua",
				html = {
					mode = "foreground",
				},
			})
		end,
	})
	use({
		"stevearc/dressing.nvim",
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("user.config._indentline")
		end,
	})
	-- cmp
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("user.config._cmp")
		end,
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"onsails/lspkind-nvim", -- Enables icons on completions
			{ -- Snippets
				"L3MON4D3/LuaSnip",
				requires = {
					"saadparwaiz1/cmp_luasnip",
					"rafamadriz/friendly-snippets",
				},
			},
		},
	})
	-- lsp
	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
		"tamago324/nlsp-settings.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"b0o/schemastore.nvim", -- JSON schema for jsonls
		"ray-x/lsp_signature.nvim",
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		"RRethy/vim-illuminate",
	})
	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("user.config._telescope")
		end,
		requires = {
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-live-grep-raw.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-treesitter/playground"
		},
	})
	-- treesitter
	use({
		{
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("user.config._treesitter")
			end,
		},
		"JoosepAlviste/nvim-ts-context-commentstring",
		"p00f/nvim-ts-rainbow",
		"windwp/nvim-ts-autotag"
	})

	-- GIT
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("user.config._gitsigns")
		end,
	})
	use("tpope/vim-fugitive")

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("user.config._terminal")
		end,
	})

	--themes
	use("luisiacc/gruvbox-baby")
	use("sainnhe/gruvbox-material")
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
