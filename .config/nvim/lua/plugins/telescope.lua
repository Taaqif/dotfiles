return {
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	dependencies = {
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-telescope/telescope-symbols.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-media-files.nvim",
	},

	init = function()
		local keymap = require("utils").keymap
		local wk = require("which-key")

		wk.register({
			["<leader>f"] = { name = "Find" },
		})
		-- Find --
		keymap("n", "<leader>fb", "<cmd>Telescope git_branches<cr>", "Checkout branch")
		keymap("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", "Colorscheme")
		keymap("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", "Find files")
		keymap(
			"n",
			"<leader>ft",
			"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
			"Find Text"
		)
		keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", "Help")
		keymap("n", "<leader>fl", "<cmd>Telescope resume<cr>", "Last Search")
		keymap("n", "<leader>fM", "<cmd>Telescope man_pages<cr>", "Man Pages")
		keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent File")
		keymap("n", "<leader>fR", "<cmd>Telescope registers<cr>", "Registers")
		keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", "Keymaps")
		keymap("n", "<leader>fC", "<cmd>Telescope commands<cr>", "Commands")
		keymap("n", "<leader>fF", "<cmd>Telescope<cr>", "Telescope")
		keymap(
			"n",
			"<leader>fs",
			"<cmd>lua require('telescope.builtin').spell_suggest(require('telescope.themes').get_cursor({}))<cr>",
			"Spell Suggestions"
		)
		keymap("n", "<leader>fP", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects")
	end,

	config = function()
		local telescope = require("telescope")
		local action_layout = require("telescope.actions.layout")
		local lga_actions = require("telescope-live-grep-args.actions")
		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"-L",
					"--hidden",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				hidden = true,
				file_ignore_patterns = { "node_modules", ".git/", ".git\\" },
				prompt_prefix = "   ",
				selection_caret = "  ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = { "truncate" },
				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				-- Developer configurations: Not meant for general override
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				mappings = {
					i = {
						["?"] = action_layout.toggle_preview,
					},
					n = { ["q"] = require("telescope.actions").close },
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			extensions = {
				media_files = {
					find_cmd = "rg", -- find command (defaults to `fd`)
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						cache_picker = {
							disabled = true,
						},
					}),
				},
				projects = {
					projects = {},
				},
				live_grep_args = {
					mappings = { -- extend mappings
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
							["<C-l>"] = lga_actions.quote_prompt({ postfix = " --t" }),
						},
					},
				},
			},
		})

		local extensions = {
			"fzf",
			"file_browser",
			"ui-select",
			"notify",
			"live_grep_args",
			"media_files",
			"projects",
		}

		pcall(function()
			for _, ext in ipairs(extensions) do
				telescope.load_extension(ext)
			end
		end)
	end,
}
