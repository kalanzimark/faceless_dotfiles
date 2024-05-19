return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	config = function()
		local null_ls = require("null-ls")
		-- for conciseness
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters
		local codeActions = null_ls.builtins.code_actions -- for code actions

		-- to setup format on save
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- configure null_ls
		null_ls.setup({
			-- setup formatters & linters
			sources = {
				--  to disable file types use
				--  "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
				formatting.prettierd, -- js/ts formatter
				formatting.stylua, -- lua formatter
				diagnostics.eslint_d.with({
					diagnostics_format = "[eslint] #{m}\n(#{c})",
					-- only enable eslint if root has .eslintrc.js
					condition = function(utils)
						return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
					end,
				}),
				-- diagnostics.eslint_d,
				codeActions.eslint_d,
			},
			-- configure format on save
			on_attach = function(current_client, bufnr)
				if current_client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								-- filter = function(client)
								-- 	--  only use null-ls for formatting instead of lsp server
								-- 	return client.name == "null-ls"
								-- end,
								bufnr = bufnr,
								--  async = false,
							})
						end,
					})
				end
			end,
		})
		vim.keymap.set("n", "<leader>nf", vim.lsp.buf.format, {})
	end,
}
