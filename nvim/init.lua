vim.cmd([[
syntax on
call plug#begin('~/.vim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate', 'branch': 'main' } " Recommended, not required.
Plug 'daltonmenezes/aura-theme', { 'rtp': 'packages/neovim' }
Plug 'nvim-tree/nvim-web-devicons' " optional
Plug 'nvim-tree/nvim-tree.lua'
Plug 'tpope/vim-endwise'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'

" CMP direct requriements
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'

" Vsnip, whatever it is
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Installing mason, LSP manager
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': 'v0.2.0' }

" Rust stuffs
Plug 'rust-lang/rust.vim'

" Indentation prettiness
Plug 'lukas-reineke/indent-blankline.nvim'

" For HTML autocomplete stuff
Plug 'windwp/nvim-ts-autotag'

" For colorizing color text
Plug 'brenoprata10/nvim-highlight-colors'

" Git
Plug 'lewis6991/gitsigns.nvim'

" Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
" Put your plugins here
" Example: Plug 'morhetz/gruvbox'

call plug#end()
set clipboard+=unnamedplus

colorscheme aura-dark
" Do it in a different file, idk if it deletes contents but i wouldnt risk it
" colorscheme embark
set number

nnoremap <C-r> <ALT-r>
]])
vim.api.nvim_set_hl(0, "Tag", {
    fg = "#a277ff",
})
-- vim keybinds
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.mouse = ""
vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>")
local function setscrolloff()
	vim.o.scrolloff = math.floor(vim.api.nvim_win_get_height(0) / 2 - 5)
end
vim.api.nvim_create_autocmd("VimResized", {
  callback = setscrolloff
})
vim.api.nvim_create_autocmd("VimEnter", {
	callback=setscrolloff
})
vim.opt.sidescrolloff=8
-- telescope setup

opts = {noremap=true, silent=true}
vim.keymap.set('n', "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>w', "w<CR>", opts)
vim.api.nvim_set_keymap(
  'n',
  '<leader>s',
  ':source ~/.config/nvim/init.lua<CR>',
  opts
)
vim.keymap.set(
  "n",
  "<leader>a",
  vim.lsp.buf.code_action,
  { desc = "Code actions" }
)

-- make background transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- Enable list mode (needed for indent guides)
vim.opt.list = true
vim.opt.listchars:append("space: ")

-- Create highlight groups FIRST
local function set_aura_indent_colors()
	-- Aura-like palette (muted + cohesive)
	-- Core cozy purples (the "background harmony" layer)
	vim.api.nvim_set_hl(0, "AuraIndent1", { fg = "#3b3252" })
	vim.api.nvim_set_hl(0, "AuraIndent2", { fg = "#443a5f" })
	vim.api.nvim_set_hl(0, "AuraIndent3", { fg = "#4d436c" })
	vim.api.nvim_set_hl(0, "AuraIndent4", { fg = "#564c79" })
	vim.api.nvim_set_hl(0, "AuraIndent5", { fg = "#605586" })

	-- Soft syntax-inspired accents (still calm)
	vim.api.nvim_set_hl(0, "AuraIndent6", { fg = "#5a7199" }) -- dusty blue
	vim.api.nvim_set_hl(0, "AuraIndent7", { fg = "#4f8f8b" }) -- muted teal
	vim.api.nvim_set_hl(0, "AuraIndent8", { fg = "#8f7a58" }) -- warm amber

	-- Current scope highlight (slightly brighter)
	vim.api.nvim_set_hl(0, "AuraScope", {
		fg = "#a277ff",
		bold = true,
	})
end

set_aura_indent_colors()

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_aura_indent_colors,
})

vim.opt.expandtab = false -- use real tabs
vim.opt.tabstop = 2 -- how wide a tab *looks*
vim.opt.shiftwidth = 2 -- how much >> indents
vim.opt.softtabstop = 2 -- tab/backspace feel

require("ibl").setup({
	indent = {
		highlight = {
			"AuraIndent1",
			"AuraIndent2",
			"AuraIndent3",
			"AuraIndent4",
			"AuraIndent5",
		},
		char = "▏",
		tab_char = {
			"▎",
			"▍",
			"▌",
			"▋",
			"▊",
			"▉",
			"█",
		},
	},
	scope = {
		highlight = "AuraScope",
	},
})

-- disabling annoying pylsp problems cuz they fuck me up
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})
vim.lsp.config("pylsp", {
	settings = {
		["rust-analyer"] = {
			rustup= {toolchain="nightly"}
		},
		pylsp = {
			plugins = {
				pycodestyle = {
					enabled = true,
					ignore = {
						"E225", -- missing whitespace around operator
						"E231", -- missing whitespace after ','
						"E251", -- unexpected spaces around keyword / parameter equals
						"E226", -- Arithmatic operators
						"E501", -- no too long errors
						"E711", -- no "comparison to none" errors
						"E712", -- no "is cond" errors
						"E741", -- no "ambiguous variable name" errors
						"E402", -- imports not at top
						"E203", -- whitespace between operator
						"W503", -- line break before binary operator
					},
				},
				mccabe={enabled=false},
				pyflakes = { enabled = false },
				autopep8 = { enabled = true },
				yapf = { enabled = true },
			},
		},
	},
})

-- setting up indentations
--require("plugins.indentationlines").setup()

require("mason").setup()
require("mason-lspconfig").setup()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults

-- OR setup with some options
require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 20,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
		custom = {
			"*.whl",
		},
	},
})

require("nvim-treesitter.configs").setup({
	ensure_installed={"html","javascript","typescript","tsx"},
	highlight = { enable = true },
	autotag={enabled=true},
})
require('nvim-ts-autotag').setup()

-- Set up nvim-cmp.
local cmp = require("cmp")

local cmp_kinds = {
	Text = " ",
	Method = " ",
	Function = " ",
	Constructor = " ",
	Field = " ",
	Variable = " ",
	Class = " ",
	Interface = " ",
	Module = " ",
	Property = " ",
	Unit = " ",
	Value = " ",
	Enum = " ",
	Keyword = " ",
	Snippet = " ",
	Color = " ",
	File = " ",
	Reference = " ",
	Folder = " ",
	EnumMember = " ",
	Constant = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
}

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	-- make cmp control when auto-popup happens, and require 3 chars
	completion = {
		autocomplete = { cmp.TriggerEvent.TextChanged }, -- let cmp control auto popup
		keyword_length = 3, -- fallback default
		max_item_count = 5,
	},

	formatting = {
		fields = { "abbr", "kind" },
		format = function(entry, vim_item)
			vim_item.menu = nil
			return vim_item
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.abort(),
		["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set select to false to only confirm explicitly selected items.
	}),

	-- set keyword_length per-source (this is the important part)
	sources = cmp.config.sources({
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "vsnip", keyword_length = 2 }, -- snippets often okay earlier
		{ name = "path", keyword_length = 2 },
		{ name = "async_path", keyword_length = 3, max_item_count = 5 },
		{ name = "async_path", keyword_length = 3, max_item_count = 5 },
	}, {
		{ name = "buffer", keyword_length = 4, max_item_count = 5 }, -- buffer matches can be noisy; raise threshold
		{ name = "nvim_lsp_signature_help" },
	}),
})

vim.keymap.set("i", "<CR>", function()
  return require("smartblocks").smart_block()
end, { expr = true })

require("nvim-highlight-colors").setup(nil, {
	mode = "background",
  enable_tailwind = false,
  debounce = 200,
})

require("line_diagnostics").setup()
vim.opt.foldcolumn = "0"
vim.opt.signcolumn = "no"
vim.wo.number = false
vim.wo.relativenumber = true

require('gitsigns').setup()
-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
	{ name = 'git' },
	}, {
		{ name = 'buffer' },
	})
	})
require("cmp_git").setup() ]]
--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok then
	for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
		vim.lsp.config(server, {
			capabilities = capabilities,
		})
	end
else
	-- fallback: set up all available LSP servers (old-style only if needed)
	for name, config in pairs(require("lspconfig.configs")) do
		vim.lsp.config(name, { capabilities = capabilities })
	end
end

require("plugins.C_Header_Helper").setup_autogen()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok then
	for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
		vim.lsp.config(server, {
			capabilities = capabilities,
		})
	end
else
	-- fallback: set up all available LSP servers (old-style only if needed)
	for name, config in pairs(require("lspconfig.configs")) do
		vim.lsp.config(name, { capabilities = capabilities })
	end
end

vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.py",
	group = "AutoFormat",
	callback = function()
		vim.cmd("silent !black --quiet '%'")
		vim.cmd("edit")
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function()
		if vim.fn.executable("cargo fmt") ~= 1 then
			return
		end

		local file = vim.api.nvim_buf_get_name(0)
		local win = vim.api.nvim_get_current_win()
		local pos = vim.api.nvim_win_get_cursor(win)

		vim.fn.system({ "cargo", "fmt" })

		vim.cmd("edit")

		local line_count = vim.api.nvim_buf_line_count(0)
		if pos[1] > line_count then
			pos[1] = line_count
		end
		vim.api.nvim_win_get_cursor(win, pos)
	end,
})
