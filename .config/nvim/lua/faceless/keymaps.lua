local keymap = vim.keymap --keymap variable

--save file
keymap.set("n", "<C-s>", ":write<CR>")

keymap.set("n", "x", '"_x') --stop x from copying text
keymap.set("i", "jk", "<ESC>") --use jk to escape
keymap.set("v", "p", '"_dP') -- dont copy replaced word when you paste new word

-- handling splits and window managment
keymap.set("n", "<leader>vs", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>hs", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>es", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>cs", ":close<CR>") -- close current split window

--handling tabs
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Resize splits with arrows
keymap.set("n", "<C-Up>", ":resize +2<CR>")
keymap.set("n", "<C-Down>", ":resize -2<CR>")
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
keymap.set("n", "<leader>bn", ":bnext<CR>") --next buffer
keymap.set("n", "<leader>bp", ":bprevious<CR>") -- previous buffer
keymap.set("n", "<leader>bb", "<C-^>") -- toggle between current and last buffer
keymap.set("n", "<leader>bc", ":bd<CR>") -- close buffer
keymap.set("n", "<leader>bh", ":new<CR>") -- horizontal split with new buffer
keymap.set("n", "<leader>bv", ":vnew<CR>") -- vertical split with new buffer

-- Visual --
-- Stay in indent mode when tabbing or spacing
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- remove Text highlight after search
keymap.set("n", "<leader>nh", ":nohlsearch<CR>")

--plugin keybinds
--vim-maximizer plugin
keymap.set("n", "<leader>ms", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true }) -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>ft", "<cmd>Telescope live_grep<cr>") -- find text in current working directory or project as you type
keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>") -- find current string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>nt", "<cmd>Telescope noice<cr>") -- list all noice messages

--noice
keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<cr>") -- noice dismiss messages

--Debug adapter
