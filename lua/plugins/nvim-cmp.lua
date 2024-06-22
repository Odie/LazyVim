return {
  "hrsh7th/nvim-cmp",

  -- Add <C-j> and <C-k> keybinds to move around in completion menus on top of
  -- the default <C-n> and <C-p> keybinds.
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    })

    return opts
  end,
}
