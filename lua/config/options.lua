-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local cmd = vim.cmd -- execute Vim commands
local opt = vim.opt
local g = vim.g

-- Reverse ; and :
-- This makes it easier to access commands as I rarely repeat commands
cmd([[
	nnoremap ; :
	nnoremap : ;
	vnoremap ; :
	vnoremap : ;
]])
