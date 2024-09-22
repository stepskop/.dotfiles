return {
	-- Lazy
	--{
	--	"olimorris/onedarkpro.nvim",
	--	priority = 1000, -- Ensure it loads first
	--},
	-- LSP Configs, Completions, Formatting
	{
		"williamboman/mason.nvim",
		opts = function()
			return require("config.mason_config").opts
		end,
		config = function(_, opts)
			require("mason").setup(opts)

			require("config.mason_config").ensure_installed(opts.ensure_installed)
		end,
	},
	{
	    'numToStr/Comment.nvim',
	    opts = {
		-- add any options here
	    }
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lspconfig")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
			  'L3MON4D3/LuaSnip',
			  build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
				  return
				end
				return 'make install_jsregexp'
			  end)(),
			  dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				-- {
				--   'rafamadriz/friendly-snippets',
				--   config = function()
				--     require('luasnip.loaders.from_vscode').lazy_load()
				--   end,
				-- },
			  },
			},
			'saadparwaiz1/cmp_luasnip',
			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
		  },
		opts = {
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			{ name = "nvim_lua" },
			{ name = "path" },
		},
		config = function()
			require("config.cmp")
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = function()
			return require("config.conform")
		end,
	},
	-- {
	-- 	"RRethy/base16-nvim",
	-- 	config = function ()
	-- 		vim.cmd([[colorscheme base16-apprentice]])
	-- 	end
	-- },
	-- Theme + UI
	{
		-- "sainnhe/everforest",
		--[[ "joshdick/onedark.vim", ]]
		--[[ "edeneast/nightfox.nvim", ]]
		-- "ellisonleao/gruvbox.nvim",
		-- "folke/tokyonight.nvim",
		-- "rebelot/kanagawa.nvim",
		-- "sho-87/kanagawa-paper.nvim",
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim tree" },
		},
		opts = function()
			return require("config.nvim-tree")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Fuzzy find files" },
		},
		config = function()
			require("config.telescope")
		end,
	},

	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {
			signcolumn = true,
			numhl = false,
			current_line_blame = true,
		},
	},
	{
	    'romgrk/barbar.nvim',
	    lazy = false,
	    dependencies = {
	      'nvim-tree/nvim-web-devicons',
	      'lewis6991/gitsigns.nvim',
	    },
	    init = function()
	      vim.g.barbar_auto_setup = false
	    end,
	    opts = {
	      sidebar_filetypes = {
		NvimTree = true,
	      },
	    },
	    keys = {
	      { '<Tab>', '<cmd>BufferNext<cr>', desc = 'Cycle to next barbar buffer' },
	      { '<S-Tab>', '<cmd>BufferPrevious<cr>', desc = 'Cycle to previous barbar buffer' },
	      { '<A-Tab>', '<cmd>BufferMoveNext<cr>', desc = 'Move barbar buffer right' },
	      { '<A-S-Tab>', '<cmd>BufferMovePrevious<cr>', desc = 'Move barbar buffer left' },
	      { '<A-x>', '<cmd>BufferClose<cr>', desc = 'Close current barbar buffer' },
	    },
	},
	-- Syntax highlight
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		opts = function()
			return require("config.treesitter")
		end,
		config =
			function(_, opts)
	


			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- Better code readability
	"HiPhish/rainbow-delimiters.nvim",
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config.indent-blankline")
		end,
	},

	-- Bracket pair
	{
		"m4xshen/autoclose.nvim",
		opts = {},
	},

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("config.dap")
		end,
	},
	{ -- Useful plugin to show you pending keybinds.
	    'folke/which-key.nvim',
	    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
	    opts = {
		      icons = {
			-- set icon mappings to true if you have a Nerd Font
			mappings = vim.g.have_nerd_font,
			-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
			-- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
			keys = vim.g.have_nerd_font and {} or {
			  Up = '<Up> ',
			  Down = '<Down> ',
			  Left = '<Left> ',
			  Right = '<Right> ',
			  C = '<C-…> ',
			  M = '<M-…> ',
			  D = '<D-…> ',
			  S = '<S-…> ',
			  CR = '<CR> ',
			  Esc = '<Esc> ',
			  ScrollWheelDown = '<ScrollWheelDown> ',
			  ScrollWheelUp = '<ScrollWheelUp> ',
			  NL = '<NL> ',
			  BS = '<BS> ',
			  Space = '<Space> ',
			  Tab = '<Tab> ',
			  F1 = '<F1>',
			  F2 = '<F2>',
			  F3 = '<F3>',
			  F4 = '<F4>',
			  F5 = '<F5>',
			  F6 = '<F6>',
			  F7 = '<F7>',
			  F8 = '<F8>',
			  F9 = '<F9>',
			  F10 = '<F10>',
			  F11 = '<F11>',
			  F12 = '<F12>',
			},
		      },

		      -- Document existing key chains
		      spec = {
			{ '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
			{ '<leader>d', group = '[D]ocument' },
			{ '<leader>r', group = '[R]ename' },
			{ '<leader>s', group = '[S]earch' },
			{ '<leader>w', group = '[W]orkspace' },
			{ '<leader>t', group = '[T]oggle' },
			{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
		      },
		},
	},
}
