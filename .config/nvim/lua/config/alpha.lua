local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local icons = require("config.icons")

local dashboard = require("alpha.themes.dashboard")
-- https://emojicombos.com/
dashboard.section.header.val = {
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⡤⠶⠶⢤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⣰⠋⣩⠟⢁⣠⣀⠀⢠⣍⡝⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⣰⡷⠋⠁⢰⠋⣿⣶⣧⠀⢀⡉⠘⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⢀⣠⢞⠭⠂⠀⠀⠘⣿⣿⡿⠟⠀⠀⠀⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⢀⡴⠛⠃⠁⠀⠀⠀⠀⠀⠘⠁⣀⡀⠀⠀⠀⠀⢿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⢰⣿⠙⠀⠿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣧⠀⠀⡇⠀⢸⢤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠘⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⠟⠀⢠⡟⠀⠸⣼⢁⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠹⣆⠀⠀⠀⠀⡀⢀⣤⢾⣿⣿⣿⠋⢀⡴⠛⠁⠀⠀⠙⢧⣸⢀⡴⣷⠀⢠⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠹⣄⡠⠖⣩⡾⣙⣿⣿⣿⡟⣡⢴⠉⠇⠀⠀⠀⠀⠀⠀⠈⠙⠢⠿⣴⣋⣷⣠⠾⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠙⠧⠼⠧⣷⣿⡿⠞⣽⠟⠁⢸⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠙⠲⢧⡤⢾⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠛⠷⢤⣾⣥⣤⣄⣸⣤⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⣏⣠⣤⠀⠀⠀⠀⠀⣀⡀⣠⣾⣽⣿⠿⠷]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣷⣄⠀⠈⠳⠄⣠⠔⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣤⠇⣀⡀⠀⢀⡀⢹⠟⣹⡿⠋⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠰⣷⣭⠟⣩⣿⣶⡶⠚⠉⢧⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣹⢰⢶⣸⣹⠏⡴⣹⠁⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⣼⣹⣾⡿⢧⡀⠀⠀⠣⡀⠀⠀⠀⠀⠀⣴⢋⠀⠀⠀⠀⠀⠀⠀⠀⠨⣙⠛⠺⡏⠁⡰⣱⠃⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣷⡏⠀⠘⣿⣄⠀⠀⠙⠦⡀⠀⠀⣸⠃⠉⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⣠⠞⣰⠃⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣇⠀⠀⠀⠈⠓⢶⠇⠀⠀⠀⠀⠀⢠⣠⣋⣀⣀⣀⡠⠔⠊⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⣤⡀⠀⠀⠘⠦⣤⣄⠀⠀⠀⠀⠙⣄⣀⣀⣠⠤⠖⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢯⣑⠲⠤⢤⡬⠿⠿⣦⣄⡀⠀⢨⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣼⡟⠁⠀⡼⠁⠀⢀⣾⠙⠃⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡴⣫⠿⡟⠀⠀⡼⠁⣠⢾⣿⠋⠀⠀⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠿⠥⠤⠿⠶⠚⠁⠐⣷⣁⣠⡷⠶⠚⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", icons.documents.Files .. "  > Find file", ":Telescope find_files <CR>"),
	dashboard.button(
		"p",
		icons.git.Repo .. "  > Find project",
		":lua require('telescope').extensions.projects.projects()<CR>"
	),
	dashboard.button("e", icons.ui.NewFile .. "  > New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", icons.ui.History .. "  > Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", icons.ui.List .. "  > Find text", ":Telescope live_grep <CR>"),
	dashboard.button("q", icons.diagnostics.Error .. "  > Quit", ":qa<CR>"),
}
local function footer()
	return "Tye Peck"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
