local mason_registry = require("mason-registry")
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
	.. "/node_modules/@vue/language-server"

local lspconfig = require("lspconfig")

lspconfig.ts_ls.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },

	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
			},
		},

		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	},
})

lspconfig.volar.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },

	init_options = {
		vue = {
			hybridMode = false,
		},
	},
})

lspconfig.clangd.setup({
	cmd = { "clangd", "--header-insertion=never", "--header-insertion-decorators=0" },
	filetypes = { "cpp", "c" },
	init_options = {
		clangdFileStatus = true,
		fallbackFlags = { "-x", "c-header" }, -- Force .h files to be treated as C headers
	},
	commands = {
		ClangdSwitchSourceHeader = {
			function()
				local bufnr = require("lspconfig").util.validate_bufnr(0)
				local params = { uri = vim.uri_from_bufnr(bufnr) }
				vim.lsp.buf_request(bufnr, "textDocument/switchSourceHeader", params, function(err, _, result)
					if err then
						error(tostring(err))
					end
					if not result then
						print("Corresponding file can’t be determined")
						return
					end
					vim.api.nvim_command("edit " .. vim.uri_to_fname(result))
					vim.api.nvim_command("bdelete " .. tostring(bufnr))
				end)
			end,
		},
	},
})
lspconfig.lua_ls.setup({
	filetypes = { "lua" },

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
lspconfig.rust_analyzer.setup({
	filetypes = { "rust" },
})
