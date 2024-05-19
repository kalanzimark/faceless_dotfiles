local opt = vim.opt

opt.clipboard = "unnamedplus" -- allows neovim yanks to go to clipboard
--opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
----opt.conceallevel = 0                        -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.mouse = "a" -- allow the mouse to be used in neovim
--opt.pumheight = 10                          -- pop up menu height
--opt.showtabline = 2                         -- always show tabs
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.background = "dark"
opt.guifont = "h18"
opt.updatetime = 1000
opt.incsearch = true --incremental search
opt.tabstop = 2
opt.shiftwidth = 2
opt.virtualedit = "block" --makes visual block mode take up full spaces even in empty columnsish
opt.autoindent = true
opt.cursorline = true -- highlight the current line
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.wrap = false -- dont display lines as one long line
opt.linebreak = true -- companion to wrap, don't split words
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.scrolloff = 10
opt.inccommand = "split" --creates a split for a preview of words being changed in realtime
opt.signcolumn = "yes"
opt.whichwrap = "bs<>[]hl" -- which "horizontal" keys are allowed to travel to prev/next line
opt.iskeyword:append("-") -- hyphenated words recognized as one word
opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
--vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use

--highlight copied text for a smalltime
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

--prevent comments from making another line comment below
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})
