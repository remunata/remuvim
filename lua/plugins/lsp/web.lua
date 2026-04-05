nixInfo.lze.load({
	{
		"html",
		for_cat = "web",
		lsp = {
			filetypes = { "html" },
		},
	},
	{
		"cssls",
		for_cat = "web",
		lsp = {
			filetypes = { "css", "scss", "less" },
		},
	},
	{
		"ts_ls",
		for_cat = "web",
		lsp = {
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		},
	},
})
