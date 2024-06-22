return {
  "nvim-telescope/telescope.nvim",

  -- Add the "C-j" and "C-k" keybinds to move telescope selection up and down
  opts = function()
    return {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = function(bufnr)
              require("telescope.actions").move_selection_next(bufnr)
            end,
            ["<C-k>"] = function(bufnr)
              require("telescope.actions").move_selection_previous(bufnr)
            end,
          },
        },
      },
    }
  end,
  keys = {
    -- Disable the Lazy's default live grep feature.
    -- We're using esearch for live grep
    { "<leader>/", false },
  },
}
