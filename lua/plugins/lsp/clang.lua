nixInfo.lze.load({
	{
		"clangd",
		for_cat = "clang",
		lsp = {
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
		},
	},
})
