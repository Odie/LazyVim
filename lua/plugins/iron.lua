return {
  "hkupty/iron.nvim",
  module = { "iron", "iron.core" },
  config = function()
    require("iron.core").setup({
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            command = { "zsh" },
          },

          -- Use ptpython for the repl
          python = require("iron.fts.python").ptpython,
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = require("iron.view").right("40%"),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        -- send_motion = ",sc",
        -- visual_send = ",ev",
        -- send_file = ",ef",
        -- send_line = ",el",
        -- send_mark = ",em",
        -- mark_motion = ",mc",
        -- mark_visual = ",mc",
        -- remove_mark = ",md",
        -- cr = ",s<cr>",
        -- interrupt = ",s<space>",
        -- exit = ",sq",
        -- clear = ",cl",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
    })
  end,
}
