-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")
local u = require("odie.utils")

local GpChatNew

local function setupGpChatBuffer(bufno)
  -- Reisze the split to something more reasonable
  u.resizeToPercentage(40)

  -- Setup the keymap if we haven't done so
  local doneKeymap = u.buf_get_var(bufno, "doneKeymap", false)
  if doneKeymap then
    return
  end

  wk.add({
    buffer = vim.api.nvim_get_current_buf(),
    { "<C-enter>", "<cmd>GpChatRespond<cr>", desc = "Generate", mode = { "i", "n" } },
    { "<localleader>g", "<cmd>GpChatRespond<cr>", desc = "Generate" },
    { "<localleader>n", GpChatNew, desc = "New Chat" },
  })

  u.buf_set_var(bufno, "doneKeymap", true)
end

local function GpChatToggle()
  local gp = require("gp")
  local bufno = gp.cmd.ChatToggle({})

  -- If the toggle activated a chat buffer, set it up now
  if bufno ~= nil then
    setupGpChatBuffer(bufno)
  end
end

GpChatNew = function()
  local gp = require("gp")
  local bufno = gp.cmd.ChatNew({})

  if bufno ~= nil then
    setupGpChatBuffer(bufno)
  end
end

wk.add({
  {
    "<C-p>",
    function()
      require("telescope.builtin").find_files()
    end,
    desc = "Find File",
  },
  { "<leader>/", "<cmd> call esearch#init() <CR>", desc = "Search Project" },

  { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch Buffers" },
  { "<leader>gs", "<cmd>Neogit<cr>", desc = "Status" },

  { "<leader>a", group = "AI", icon = { icon = "🤖" } },
  { "<leader>at", GpChatToggle, desc = "Toggle Chat" },
  { "<leader>ap", ":'<,'>GpChatPaste<cr>", desc = "Paste Chat", mode = "v" },
  { "<leader>an", GpChatNew, desc = "New Chat" },
  { "<leader>ad", "<cmd>GpChatDelete<cr>", desc = "Delete Chat", icon = { icon = "", color = "red" } },
  { "<leader>a/", "<cmd>GpChatFinder<cr>", desc = "Find Chat" },
  { "<leader>arc", "<cmd>GpReferenceCurrentFunction<cr>", desc = "Reference current function" },
  { "<leader>arf", "<cmd>GpReferenceCurrentFile<cr>", desc = "Reference current file" },
  {
    "<leader>arr",
    function()
      print("reloading gp...")
      local gp = u.reload_module("gp")
      local plugin_spec = require("plugins.gp")[1]
      if plugin_spec then
        plugin_spec.config()
      end
    end,
    desc = "Reload Gp",
  },

  {
    "<leader>fN",
    function()
      print(vim.api.nvim_buf_get_name(0))
    end,
    desc = "Print File Name",
  },
})
