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

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

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

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	--utils
	use("nvim-lua/plenary.nvim")
	use({
		"lewis6991/impatient.nvim",
		config = configure("_impatient"),
	})
	use("nvim-lua/popup.nvim")
	use("stevearc/dressing.nvim")
	use({
		"rcarriga/nvim-notify",
		config = configure("_notify"),
	})
	use({
		"goolord/alpha-nvim",
		config = configure("_alpha"),
	})
	use("antoinemadec/FixCursorHold.nvim")

	use({
		"Darazaki/indent-o-matic",
		config = function()
			require("indent-o-matic").setup({})
		end,
	})
	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	})

	use("tpope/vim-surround")
	use("mg979/vim-visual-multi")
	use("tpope/vim-repeat")
	use("AndrewRadev/switch.vim")
	use("moll/vim-bbye")
	use("svermeulen/vim-cutlass")
	use("andymass/vim-matchup")

	use({
		"windwp/nvim-spectre",
		config = configure("_spectre"),
	})
	use({
		"numToStr/Comment.nvim",
		config = configure("_comment"),
	})
	use({
		"akinsho/bufferline.nvim",
		config = configure("_bufferline"),
	})
	use({
		"windwp/nvim-autopairs",
		config = configure("_autopairs"),
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = configure("_lualine"),
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = configure("_indentline"),
	})
	use({
		"kyazdani42/nvim-tree.lua",
		config = configure("_nvimtree"),
	})
	use({
		"folke/trouble.nvim",
		config = configure("_trouble"),
	})
	use({
		"matbme/JABS.nvim",
		config = configure("_JABS"),
	})
	use({
		"folke/which-key.nvim",
		config = configure("_whichkey"),
	})
	use({
		"max397574/better-escape.nvim",
		config = configure("_better_escape"),
	})
	-- use({
	-- 	"github/copilot.vim",
	-- 	config = function() end,
	-- })
	use({
		"norcalli/nvim-colorizer.lua",
		config = configure("_colorizer"),
	})
	use({
		"ahmedkhalf/project.nvim",
		config = configure("_project"),
	})
	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = configure("_telescope"),
		requires = {
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-live-grep-raw.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			"nvim-telescope/telescope-file-browser.nvim",
		},
	})
	-- cmp
	use({
		"hrsh7th/nvim-cmp",
		config = configure("_cmp"),
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
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
		config = configure("_lsp"),
		requires = {
			"williamboman/nvim-lsp-installer",
			"lukas-reineke/lsp-format.nvim",
			"tamago324/nlsp-settings.nvim",
			"nvim-lua/lsp-status.nvim",
			"b0o/schemastore.nvim", -- JSON schema for jsonls
			"ray-x/lsp_signature.nvim",
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"RRethy/vim-illuminate",
			"jose-elias-alvarez/null-ls.nvim",
		},
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = configure("_treesitter"),
		requires = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"p00f/nvim-ts-rainbow",
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/playground",
		},
	})

	-- GIT
	use({
		"lewis6991/gitsigns.nvim",
		config = configure("_gitsigns"),
	})
	use("tpope/vim-fugitive")

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		config = configure("_terminal"),
	})

	--themes
	use("luisiacc/gruvbox-baby")
	use("sainnhe/gruvbox-material")
	use("ellisonleao/gruvbox.nvim")
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
