return {

	"nvimdev/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			-- keybinds for navigation in lspsaga window
			scroll_preview = { scroll_down = "<C-j>", scroll_up = "<C-k>" },
			-- use enter to open file with definition preview
			definition = {
				edit = "<CR>",
			},
			-- ui = {
			-- 	colors = {
			-- 		normal_bg = "#022746",
			-- 	},
			-- },
		})
	end,
}
