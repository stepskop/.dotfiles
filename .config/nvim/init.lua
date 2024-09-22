vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"

-- Indent
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.pumheight = 10

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local map = vim.keymap.set

map("i", "<C-s>", "<ESC>:w<CR>")
map("n", "<C-s>", ":w<CR>")

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

function Sad(line_nr, from, to, fname)
  vim.cmd(string.format("silent !sed -i '%ss/%s/%s/' %s", line_nr, from, to, fname))
end

function IncreasePadding()
  Sad('04', "x=0", "x=32", '~/.dotfiles/.config/alacritty/alacritty.toml')
  Sad('04', "y=0", "y=32", '~/.dotfiles/.config/alacritty/alacritty.toml')
end

function DecreasePadding()
  Sad('04', "x=32", "x=0", '~/.dotfiles/.config/alacritty/alacritty.toml')
  Sad('04', "y=32", "y=0", '~/.dotfiles/.config/alacritty/alacritty.toml')
end

vim.cmd[[
  augroup ChangeAlacrittyPadding
   au! 
   au VimEnter * lua DecreasePadding()
   au VimLeavePre * lua IncreasePadding()
  augroup END 
]]

require("config.lazy")

-- somewhere in your config:
--vim.cmd("colorscheme onedark_dark")
