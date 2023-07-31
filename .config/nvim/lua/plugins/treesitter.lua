return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufRead",

	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"RRethy/nvim-treesitter-textsubjects",
		"nvim-treesitter/nvim-treesitter-refactor",
		"mfussenegger/nvim-treehopper",
		"JoosepAlviste/nvim-ts-context-commentstring",
		-- "mrjones2014/nvim-ts-rainbow",
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-context",

		{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
	},

	config = function()
		local treesitter_context_ok, treesitter_context = pcall(require, "treesitter-context")
		treesitter_context.setup({})
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"typescript",
				"javascript",
				"json",
				"json5",
				"jsonc",
				"comment",
        "c_sharp"
			},
			highlight = {
				enable = true,
			},
			indent = { enable = true },
			autopairs = { enable = true },
			autotag = {
				enable = true,
			},
			matchup = {
				enable = true,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			-- rainbow = {
			-- 	enable = true,
			-- 	extended_mode = true
			-- },
			textsubjects = {
				enable = true,
				prev_selection = ",", -- (Optional) keymap to select the previous selection
				keymaps = {
					["."] = "textsubjects-smart",
					[";"] = "textsubjects-container-outer",
					["i;"] = "textsubjects-container-inner",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
				},
			},
		})

		require("nvim-treesitter.install").compilers = { vim.fn.getenv("CC"), "cc", "zig", "gcc", "clang", "cl" }
	end,
}
