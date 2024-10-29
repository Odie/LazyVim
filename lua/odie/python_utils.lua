local ts_utils = require("nvim-treesitter.ts_utils")
local iron = require("iron.core")

local PU = {}

-- Function to send the current top level express/statement to the REPL
function PU.send_current_expression_to_repl()
  -- Get the current cursor position
  local cursor_node = ts_utils.get_node_at_cursor()

  -- Traverse up the AST and try to some kind of construct that is at the
  -- "top-level", which is one level down from the `module` node.
  -- This might be a function declaration, variable assignment, class declaration,
  -- import statement, etc.
  local stmt_node
  while cursor_node do
    local parent_node = cursor_node:parent()
    if parent_node and parent_node:type() == "module" then
      stmt_node = cursor_node
      break
    end
    cursor_node = parent_node
  end

  -- If we found a top level node, send its contents the repl.
  if stmt_node then
    -- Get the start and end lines of the expression statement
    local start_row, start_col, end_row, end_col = stmt_node:range()

    -- Extract the lines from the buffer
    local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)

    -- Send the code to the REPL using IronSend
    iron.send(nil, lines)
  else
    print("No `expression_statement` found at the cursor position")
  end
end

return PU
