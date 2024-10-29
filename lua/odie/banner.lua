local Banner = {}

function create_middle_line(text)
  local total_width = 70
  local content_width = total_width - 4 -- Subtract 4 for "## " and " ##"
  local padding = content_width - #text
  local left_padding = math.floor(padding / 2)
  local right_padding = padding - left_padding

  return "##" .. string.rep(" ", left_padding) .. text .. string.rep(" ", right_padding) .. "##"
end

function Banner.create_banner()
  -- Get the current cursor position
  local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))

  -- Prompt the user for input
  local user_input = vim.fn.input("Enter banner text: ")

  -- Create the banner lines
  local top_bottom_line = string.rep("#", 70)
  local middle_line = create_middle_line(user_input)

  -- Combine the lines into a banner
  local banner = top_bottom_line .. "\n" .. middle_line .. "\n" .. top_bottom_line

  -- Insert the banner at the cursor position
  vim.api.nvim_buf_set_text(0, cursor_row - 1, cursor_col, cursor_row - 1, cursor_col, vim.split(banner, "\n"))
end

return Banner
