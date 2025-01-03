local wk = require("which-key")
wk.add({
  buffer = vim.api.nvim_get_current_buf(),
  { "<leader>k", group = "Sexp Elements" },
  { "<leader>ks", "<Plug>(sexp_capture_next_element)", desc = "Slurp Next Element" },
  { "<leader>kb", "<Plug>(sexp_emit_tail_element)", desc = "Emit Tail Element" },
})
