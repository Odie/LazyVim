return {
  "notjedi/nvim-rooter.lua",
  lazy = false,
  config = function()
    require("nvim-rooter").setup({
      rooter_patterns = { ".git", ".hg", ".svn", "package.json", "pyproject.toml" },
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      -- trigger_patterns = { '*' },
      -- manual = false,
    })
  end,
}
