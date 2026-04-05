nixInfo.lze.load({
	{
		"jdtls",
		for_cat = "java",
		lsp = {
			filetypes = { "java" },
			root_markers = {
				{ "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts", ".git" },
				{ "build.xml", "pom.xml", "build.gradle", "build.gradle.kts" },
			},
		},
	},
})
