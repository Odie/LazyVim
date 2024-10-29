local M = {}

function M.buf_get_var(buf, var_name, default)
  local status, result = pcall(vim.api.nvim_buf_get_var, buf, var_name)
  if status then
    return result
  else
    return default
  end
end

-- This function is only here make the get/set call pair look consistent
function M.buf_set_var(buf, var_name, value)
  return vim.api.nvim_buf_set_var(buf, var_name, value)
end

function M.resizeToPercentage(percentage)
  local cols = math.floor(vim.o.columns * percentage / 100)
  vim.cmd("vertical resize " .. cols)
end

function M.unload_module(name)
  local dir = name .. "/"
  local dot = name .. "."
  for key in pairs(package.loaded) do
    if vim.startswith(key, dir) or vim.startswith(key, dot) or key == name then
      package.loaded[key] = nil
      print("Unloaded: ", key)
    end
  end
end

function M.reload_module(name)
  M.unload_module(name)
  return require(name)
end

function M.tbl_list_remove_by_value(tbl, target_value)
  local idx
  for i, v in ipairs(tbl) do
    if v == target_value then
      idx = i
      break
    end
  end

  if idx then
    table.remove(tbl, idx)
  end
end

return M
