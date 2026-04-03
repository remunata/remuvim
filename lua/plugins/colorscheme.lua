nixInfo.lze.load({
	{
		"trigger_colorscheme",
		event = "VimEnter",
		load = function(_name)
			vim.schedule(function()
				vim.cmd.colorscheme(nixInfo(nil, "settings", "colorscheme"))
			end)
		end,
	},
	{
		"nightfox.nvim",
		auto_enable = true,
		colorscheme = { "nightfox", "terafox" },
	},
})
