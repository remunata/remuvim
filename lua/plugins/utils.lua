nixInfo.lze.load({
	{
		"nvim-surround",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function(plugin)
			require("nvim-surround").setup()
		end,
	},
	{
		"fidget.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function(plugin)
			require("fidget").setup({})
		end,
	},
})
