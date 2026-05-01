local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug 'nvim-treesitter/nvim-treesitter'--, { 'do': ':TSUpdate' }
Plug 'daltonmenezes/aura-theme'--, { 'rtp': 'packages/neovim' }
Plug 'nvim-tree/nvim-web-devicons' -- optional
Plug 'nvim-tree/nvim-tree.lua'
vim.call('plug#end')

home=os.getenv("HOME")
package.path = home .. "/.config/nvim/?.lua;" .. package.path

require"common"
require"vimtree"
