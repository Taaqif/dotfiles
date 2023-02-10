local o = vim.opt
local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	relativenumber = true,
	-- colorcolumn = "120",
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	laststatus = 3,
	numberwidth = 4, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = true, -- display lines as one long line
	scrolloff = 8, -- is one of my fav
	sidescrolloff = 8,
	background = "dark",
	lazyredraw = true,
	autoindent = true,
	showbreak = "↪ ",

	spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
	spelloptions = "camel",
	spell = false,
	-- shell = "pwsh.exe -NoLogo"
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

--cmd height 0
vim.cmd("set cmdheight=0")

--hide tilde for blank lines
vim.cmd("let &fcs='eob: '")

-- set switchbuff to current buffer
vim.cmd("set switchbuf=uselast")

--gui font
vim.cmd("let &guifont = 'OperatorMonoSSmLig Nerd Font:h11'")

if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
	}
end
vim.opt.list = true
vim.opt.listchars = "eol:↵,trail:·,space:·,tab:  "
require("utils.statuscolumn")
