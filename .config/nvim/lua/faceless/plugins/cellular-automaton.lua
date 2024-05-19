return {
	"eandrju/cellular-automaton.nvim",
	config = function()
		vim.keymap.set("n", "<leader>ag", "<cmd>CellularAutomaton game_of_life<CR>")
		vim.keymap.set("n", "<leader>ar", "<cmd>CellularAutomaton make_it_rain<CR>")
	end,
}
