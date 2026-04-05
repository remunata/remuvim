nixInfo.lze.load({
	{
		"jsonls",
		for_cat = "yjs",
		lsp = {
			filetypes = { "json", "jsonc" },
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	{
		"yamlls",
		for_cat = "yjs",
		lsp = {
			filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})
