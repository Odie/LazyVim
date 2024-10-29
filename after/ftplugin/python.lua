vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4

local core = require("iron.core")
local ft = vim.bo.filetype
local PU = require("odie.python_utils")

local wk = require("which-key")
wk.add({
  buffer = vim.api.nvim_get_current_buf(),
  {"<localleader>e", desc = "Eval"},
  {"<localleader>eb", function() core.send_file(ft) end, desc = 'Eval buffer'},
  -- {"<localleader>el", function() core.send_line() end, desc = 'Eval current line'},
  {"<localleader>el", function() PU.send_current_expression_to_repl() end, desc = 'Eval current line'},
  -- {"<localleader>ev", function() core.visual_send() end, desc = 'Eval selection'},
  {"<localleader>ev", function() core.visual_send() end, desc = 'Eval selection', mode="v"},

  {"<localleader>s", desc = "repl"},
  {"<localleader>sa", function() core.focus_on(ft) end, desc = 'Switch to repl'},
  {"<localleader>sh", function() core.hide_repl() end, desc = 'Hide'},
  {"<localleader>sr",
    function()
      core.repl_restart()
      core.repl_for(ft)
    end, desc = 'Hard Reset'},

  {"<localleader>sq", function() core.close_repl() end, desc = 'Quit'},
  {"<localleader>s<cr>", function() core.send(nil, string.char(13)) end, desc = 'Send carriage-return'},
  {"<localleader>s<space>", function() core.send(nil, string.char(03)) end, desc = 'Send Interrupt'},

  {"<localleader>r", desc = "Reload"},
  {"<localleader>rr", function()
      core.send(nil, "module_reloader.reload_module_by_path('" .. vim.api.nvim_buf_get_name(0) .. "')\n")
    end, desc = "Current module"},
  {"<localleader>rs", function() core.send(nil, "module_reloader.reload_stale_modules()\n") end, desc = "Stale modules" },
  {"<localleader>mb", function() require("odie.banner").create_banner() end, desc = "Create banner" },
})

