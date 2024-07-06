-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local wk = require("which-key")

wk.register({
  ["<C-p>"] = { LazyVim.pick("auto"), "Find File" },
}, { prefix = "" })

map("n", "<leader>/", "<cmd> call esearch#init() <CR>", { desc = "Search Project" })

wk.register({
  b = {
    name = "buffer",
    b = { "<cmd>Telescope buffers<cr>", "Switch Buffers" },
  },
}, { prefix = "<leader>" })
