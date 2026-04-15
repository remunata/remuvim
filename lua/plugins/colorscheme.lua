nixInfo.lze.load({
	{
		"trigger_colorscheme",
		event = "VimEnter",
		load = function()
			vim.schedule(function()
				vim.cmd.colorscheme(nixInfo(nil, "settings", "colorscheme"))
			end)
		end,
	},
	{
		"catppuccin-nvim",
		auto_enable = true,
		colorscheme = { "catppuccin-nvim" },
		after = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				float = {
					transparent = true,
				},
			})
		end,
	},
})
