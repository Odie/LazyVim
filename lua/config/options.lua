-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local cmd = vim.cmd -- execute Vim commands
local opt = vim.opt
local g = vim.g
local map = vim.keymap.set

g.maplocalleader = "," -- Local leader is comma

-- Reverse ; and :
-- This makes it easier to access commands as I rarely repeat commands
cmd([[
	nnoremap ; :
	nnoremap : ;
	vnoremap ; :
	vnoremap : ;
]])

-- Keep the cursor in the middle of the screen after paging up/down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-y>", "<C-u>zz")

-- Move blocks of code up and down using J and K in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '>-3<CR>gv=gv")

-- Enable pasting over current selection
map("x", "<leader>p", '"_dP')
