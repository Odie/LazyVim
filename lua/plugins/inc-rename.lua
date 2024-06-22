return {
  "smjonas/inc-rename.nvim",
  cmd = "IncRename",
  config = function()
    require("inc_rename").setup()
  end,
  keys = {
    -- mnemonic for LSP-Action-Rename
    {
      "<leader>lar",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      desc = "Rename Symbol",
      expr = true,
    },
  },
}
