return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			--install language servers
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"html",
					"cssls",
					"emmet_ls",
					"tailwindcss",
					"eslint",
				},
				automatic_installation = true,
			})
		end,
	},

	--install lsp config to enable communication between neovim and the language servers
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "antosha417/nvim-lsp-file-operations", config = true }, --when you rename a file save with "wa" to write to all affected files
		},
		config = function()
			local lspconfig = require("lspconfig")
			--enable completion for language servers
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Change the Diagnostic symbols in the sign column (gutter)
			-- local signs = { Error = "❌", Warn = "⚠️ ", Hint = " ", Info = " " }
			local signs = { Error = " ", Warn = " ", Hint = "💡", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			--enable lsp keymaps when language server is attached on buffer
			local on_attach = function(client, bufnr)
				-- enable keybinds only for when lsp server available
				-- keybind options
				local opts = { noremap = true, silent = true, buffer = bufnr }
				local keymap = vim.keymap -- for conciseness

				-- set keybinds
				keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
				keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- see definition
				keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- go to declaration
				keymap.set("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
				keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
				keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
				keymap.set("n", "<leader>r", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
				keymap.set("n", "<leader>rp", "<cmd>Lspsaga project_replace old_name new_name<CR>", opts) -- rename in entire project
				keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
				keymap.set("n", "<leader>D", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
				keymap.set("n", "[d", "<cmd>:Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
				keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
				keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor, press K again to enter document
				keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end

			--lsp servers table
			local myservers = { "tsserver", "html", "cssls", "lua_ls", "tailwindcss", "eslint", "emmet_ls" }

			--loop for server table
			for _, lsp in ipairs(myservers) do
				if lsp == "lua_ls" then
					lspconfig.lua_ls.setup({

						on_attach = on_attach,
						capabilities = capabilities,

						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								-- make the language server recognize "vim" global
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									-- make language server aware of runtime files
									-- library = {
									-- 	[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									-- 	[vim.fn.stdpath("config") .. "/lua"] = true,
									-- },
									library = vim.api.nvim_get_runtime_file("", true),
								},
							},
						},
					})
				end

				if lsp == "emmet_ls" then
					lspconfig.emmet_ls.setup({
						-- on_attach = on_attach,
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
							"javascript",
						},
						init_options = {
							html = {
								options = {
									-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
									["bem.enabled"] = true,
								},
							},
						},
					})
				end
				lspconfig[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end
			--remove that irriating javascript module warning
			local function filter_tsserver_diagnostics(_, result, ctx, config)
				if result.diagnostics == nil then
					return
				end
				-- ignore some tsserver diagnostics
				local idx = 1
				while idx <= #result.diagnostics do
					local entry = result.diagnostics[idx]
					-- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
					if entry.code == 80001 then
						-- { message = "File is a CommonJS module; it may be converted to an ES module.", }
						table.remove(result.diagnostics, idx)
					else
						idx = idx + 1
					end
				end
				vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
			end

			vim.lsp.handlers["textDocument/publishDiagnostics"] = filter_tsserver_diagnostics
		end,
	},
}
