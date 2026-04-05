nixInfo.lze.load({
	{
		"gopls",
		for_cat = "go",
		lsp = {
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
		},
	},
})
