return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		require("dapui").setup()
		require("dap-go").setup()

		local dap, dapui = require("dap"), require("dapui")

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		vim.keymap.set("n", "<Leader>dp", ":DapToggleBreakpoint<CR>") --create Debug breakpoint
		vim.keymap.set("n", "<Leader>du", ":DapUiToggle<CR>") --open Debug ui
		vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>") --continue debugging
		vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>") -- cancel debugging
		vim.keymap.set("n", "<Leader>ds", ":DapStepOver<CR>") --Debug step
	end,
}
