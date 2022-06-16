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
	compile_path = vim.fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	-- perfomance
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("config.impatient")
		end,
	})
	use("nathom/filetype.nvim") 
	--utils
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("RishabhRD/popfix")
	use("stevearc/dressing.nvim")
	
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("config.notify")
		end,
	})
	use({
		"goolord/alpha-nvim",
		config = function()
			require("config.alpha")
		end,
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
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("config.fidget")
		end,
	})

	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("AndrewRadev/switch.vim")
	use("moll/vim-bbye")
	use("svermeulen/vim-cutlass")
	use("andymass/vim-matchup")
	use("wellle/targets.vim")
	use("mattn/emmet-vim")

	use({
		"mg979/vim-visual-multi",
		config = function()
			require("config.visualmulti")
		end,
	})
	use({
		"windwp/nvim-spectre",
		event = "BufWinEnter",
		config = function()
			require("config.spectre")
		end,
	})
	use({
		"ggandor/lightspeed.nvim",
		config = function()
			require("config.lightspeed")
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("config.comment")
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		event = "BufWinEnter",
		config = function()
			require("config.bufferline")
		end,
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("config.autopairs")
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config.lualine")
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config.indentline")
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		event = "BufWinEnter",
		config = function()
			require("config.nvimtree")
		end,
	})
	use({
		"folke/trouble.nvim",
		config = function()
			require("config.trouble")
		end,
	})
	use({
		"matbme/JABS.nvim",
		event = "BufWinEnter",
		config = function()
			require("config.JABS")
		end,
	})
	use({
		"folke/which-key.nvim",
		event = "BufWinEnter",
		config = function()
			require("config.whichkey")
		end,
	})
	use({
		"max397574/better-escape.nvim",
		config = function()
			require("config.better_escape")
		end,
	})
	-- use({
	-- 	"github/copilot.vim",
	-- 	config = function() end,
	-- })
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("config.colorizer")
		end,
	})
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("config.project")
		end,
	})
	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config.telescope")
		end,
		requires = {
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			"nvim-telescope/telescope-file-browser.nvim",
		},
	})
	-- cmp
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("config.cmp")
		end,
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
		config = function()
			require("config.lsp")
		end,
		requires = {
			"williamboman/nvim-lsp-installer",
			"nvim-lua/lsp-status.nvim",
			"b0o/schemastore.nvim", -- JSON schema for jsonls
			"ray-x/lsp_signature.nvim",
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"RRethy/vim-illuminate",
			"RishabhRD/nvim-lsputils",
			"jose-elias-alvarez/null-ls.nvim",
		},
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
		run = ":TSUpdate",
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
		event = "BufRead",
		config = function()
			require("config.gitsigns")
		end,
	})
	use("tpope/vim-fugitive")
	use({
		"kdheepak/lazygit.nvim",
		config = function()
			require("config.lazygit")
		end,
	})

	-- Terminal
	use({
		-- "voldikss/vim-floaterm",
		"akinsho/toggleterm.nvim",
		event = "BufWinEnter",
		setup = function()
			-- require("config.floatterm")
		end,
		config = function ()
			require("config.toggleterm")
		end
	})

	--themes
	use("sainnhe/gruvbox-material")
	use("rebelot/kanagawa.nvim")
  -- use("EdenEast/nightfox.nvim")
	
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
