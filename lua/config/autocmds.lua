-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

local create_autocmd = vim.api.nvim_create_autocmd

-- Automatically set +x on shebang files
create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("AutoSetExeBit", { clear = true }),
  callback = function()
    local line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
    if string.find(line, "^#!") then
      vim.fn.jobstart({ "chmod", "u+x", vim.fn.expand("%:p") })
    end
  end,
})
