-- global options
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.have_nerd_font = true
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- options
vim.opt.clipboard = "unnamedplus" -- sync clipboard between OS and neovim
vim.opt.cmdheight = 0 -- hide command line unless needed
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- options for insert mode completion
vim.opt.breakindent = true -- wrap indent to match  line start
vim.opt.confirm = true -- raise a dialog asking if you wish to save the current file(s)
vim.opt.copyindent = true -- copy the previous indentation on autoindenting
vim.opt.cursorline = true -- highlight the text line of the cursor
vim.opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" }) -- enable linematch diff algorithm
vim.opt.expandtab = true -- enable the use of space in tab
vim.opt.fillchars = { eob = " " } -- disable `~` on nonexistent lines`
vim.opt.foldcolumn = "1" -- show foldcolumn
vim.opt.foldenable = true -- enable fold
vim.opt.foldlevel = 99 -- set high foldlevel
vim.opt.foldlevelstart = 99 -- start with all code unfolded
vim.opt.ignorecase = true -- case insensitive searching
vim.opt.infercase = true -- infer cases in keyword completion
vim.opt.laststatus = 3 -- global statusline
vim.opt.linebreak = true -- wrap lines at 'breakat'
vim.opt.mouse = "a" -- enable mouse support
vim.opt.preserveindent = true -- preserve indent structure as much as possible
vim.opt.pumheight = 10 -- height of the pop up menu
vim.opt.number = true -- show numberline
vim.opt.relativenumber = true -- show relative numberline
vim.opt.shiftwidth = 0 -- number of space inserted for indentation; when zero the 'tabstop' value will be used
vim.opt.tabstop = 2 -- set the number of space in a tab to 4
vim.opt.softtabstop = 2 -- can be differnt from tabstop
vim.opt.shortmess = vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { s = true, I = true }) -- disable search count wrap and startup messages
vim.opt.showmode = false -- disable showing modes in command line
vim.opt.showtabline = 2 -- always display tabline
vim.opt.signcolumn = "yes" -- always show the sign column
vim.opt.smartcase = true -- case sensitive searching
vim.opt.splitbelow = true -- splitting a new window below the current one
vim.opt.splitright = true -- splitting a new window at the right of the current one
vim.opt.smoothscroll = true -- enable smooth scrolling
vim.opt.tabstop = 2 -- number of space in a tab
vim.opt.termguicolors = true -- enable 24-bit RGB color in the TUI
vim.opt.timeoutlen = 300 -- shorten key timeout length a little bit for which-key
vim.opt.title = true -- set terminal title to the filename and path
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 250 -- length of time to wait before triggering the plugin
vim.opt.virtualedit = "block" -- allow going past end of line in visual block mode
vim.opt.scrolloff = 10 -- lines of context
vim.opt.wrap = false -- disable wrapping of lines longer than the width of window
vim.opt.writebackup = false -- disable making a backup before overwriting a file
vim.opt.swapfile = false -- ask what state to recover when opening a file that was not saved
-- set how neovim will display certain whitespace characters in the editor
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
