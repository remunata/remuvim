nixInfo.lze.load({
	{
		"conform.nvim",
		auto_enable = true,
		keys = {
			{ "<leader>FF", desc = "[F]ormat [F]ile" },
		},
		after = function(plugin)
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = nixInfo(nil, "settings", "cats", "lua") and { "stylua" } or nil,
					rust = nixInfo(nil, "settings", "cats", "rust") and { "rustfmt" } or nil,
					go = nixInfo(nil, "settings", "cats", "go") and { "gofumpt" } or nil,
					php = function(bufnr)
						local bufname = vim.api.nvim_buf_get_name(bufnr)
						-- If inside "Views", return empty table {}
						-- This prevents php-cs-fixer from running and triggers LSP fallback
						if bufname:match("/Views/") then
							return {}
						end
						-- Otherwise, use php-cs-fixer for everything else (Controllers, Models)
						return { "php_cs_fixer" }
					end,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>FF", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 3000,
				})
			end, { desc = "[F]ormat [F]ile" })
		end,
	},
})
