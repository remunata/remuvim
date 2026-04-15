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
	{
		"nvim-autopairs",
		auto_enable = true,
		event = "InsertEnter",
		after = function(plugin)
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"nvim-ts-autotag",
		auto_enable = true,
		event = { "BufReadPre", "BufNewFile" },
		after = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"neogen",
		cmd = { "Neogen" },
		keys = {
			{ "<leader>cd", "<cmd>Neogen<CR>", mode = { "n" }, desc = "Generate [d]ocs" },
		},
		after = function(plugin)
			require("neogen").setup({})

			vim.keymap.set("n", "<leader>cd", function()
				require("neogen").generate()
			end, { desc = "Generate [d]ocs" })
		end,
	},
})
