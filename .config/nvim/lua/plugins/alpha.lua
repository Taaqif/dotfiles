return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		local icons = require("icons")
		dashboard.section.header.val = {
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⡞⣿⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣄⠀⠀⣇⣿⡄⠀⠀⠀⠀⣴⣿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡆⠀⢻⡜⣷⡀⠀⠀⣼⢿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⣿⢀⣸⣇⠘⣷⡀⠀⣿⠸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡏⠀⣿⣾⣿⡿⠀⠘⣷⡀⣿⡆⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠀⢰⠿⣿⣿⠃⢠⣄⠸⣇⢸⣧⠀⢻⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠇⠀⣠⠶⠟⠁⠀⠀⣿⢷⣿⠀⣿⡀⠈⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡏⠀⣼⠃⠀⠀⠀⠀⢠⡿⠀⢻⣆⢸⠇⢠⠀⢻⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠁⣠⡏⠀⠀⠀⠀⢀⣾⠃⠀⠀⢿⣾⠀⢸⡆⠀⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡀⢻⡇⠀⠀⠀⣰⡟⠁⠀⠀⠀⣼⠏⠀⡜⣿⠀⢸⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣻⣧⠀⠙⠀⣠⡾⠋⠀⠀⠀⠀⠀⠀⠀⣰⠇⣿⢀⣾⣧⣤⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⣀⣀⣴⠟⢉⣽⣿⣿⡿⠧⢴⣾⠏⠀⠀⠀⠀⠀⠀⢀⣿⣴⠟⠀⣿⣾⣙⣻⡟⠉⣿⣦⣄⣤⣤⣄⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⣴⠟⠉⠉⠉⢣⡾⢹⠟⣛⣗⡒⠲⣯⠀⠀⠀⠀⠀⠀⢀⡼⠘⠋⠀⣼⣃⣊⣉⣹⣅⣤⣧⣼⠟⠁⠀⠉⣻⠖⠛⢶⣄⠀⠀]],
			[[⠀⠀⢠⡶⠟⠛⢳⣄⠀⠀⢈⣿⣌⣥⣤⣤⣭⡽⠿⣦⠤⣤⣴⣶⣶⣟⣁⣠⣤⡾⠯⠉⠉⠉⠀⣽⠏⢹⡏⠀⢀⣠⡼⠋⠀⠀⠀⠹⣷⡀]],
			[[⢀⣴⡟⠛⠋⠉⠉⠛⠻⣾⠛⣽⠿⠛⠒⠒⠒⠛⠋⠉⠉⠉⠉⠁⠀⠀⠐⠒⠚⠓⠂⠀⠀⠀⢀⣏⢰⣾⣇⣰⡟⠋⠀⠀⠀⠀⠀⠀⠈⢿]],
			[[⣿⠋⠀⠀⡴⠛⠛⠶⣄⡈⣄⣿⣉⣉⠉⠉⠁⠀⠀⠀⢀⣀⣤⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣿⣿⣿⠏⠹⣄⣀⡠⠔⠋⠙⢦⣀⣀⣼]],
			[[⠙⠳⠤⣼⣇⠀⠀⢀⣽⡿⠉⠁⠈⠙⢷⣟⣳⡶⠶⠟⠋⠉⠀⣀⣹⣿⡒⠛⠛⠋⠉⠉⠉⠛⡿⠉⠉⠛⠿⠶⠿⣅⠀⠀⠀⠀⠀⢻⣟⠁]],
			[[⠀⠀⠀⠀⠙⠛⠛⠛⣻⡃⠀⠀⠀⠀⠀⣿⠋⠀⠀⠀⠀⠐⠋⠁⠀⠉⠙⢳⣶⠶⠛⠛⠒⠚⠳⡀⠀⠀⠀⠀⠀⠹⣇⠀⠀⠀⠀⢸⣿⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠘⠳⣶⣤⣄⣀⣴⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡇⠀⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⢀⣿⡶⠤⠴⠶⠛⠁⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠓⠶⠤⣤⣤⣤⣤⣤⣤⡴⠶⠶⠟⠳⠶⠶⠶⠞⠛⠛⠛⠛⠛⠛⠛⠛⠛⠋⠀⠀⠀⠀⠀⠀⠀]],
		}
		dashboard.section.buttons.val = {
			dashboard.button("f", icons.documents.Files .. "  ➜ Find file", ":Telescope find_files hidden=true<CR>"),
			dashboard.button(
				"p",
				icons.git.Repo .. "  ➜ Find project",
				":lua require('telescope').extensions.projects.projects()<CR>"
			),
			dashboard.button("e", icons.ui.NewFile .. "  ➜ New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("r", icons.ui.History .. "  ➜ Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("t", icons.ui.List .. "  ➜ Find text", ":Telescope live_grep hidden=true<CR>"),
			dashboard.button("q", icons.diagnostics.Error .. "  ➜ Quit", ":qa<CR>"),
		}
		local function footer()
			return vim.api.nvim_command_output([[echo matchstr(execute('version'), 'NVIM [^\n]*')]])
		end

		dashboard.section.footer.val = footer()

		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		dashboard.opts.opts.noautocmd = true

		require("alpha").setup(dashboard.opts)
	end,
}
