return {
  "kwkarlwang/bufjump.nvim",
  config = function()
    require("bufjump").setup({
      backward_key = "[b",
      forward_key = "]b",
      on_success = nil,
    })
  end,
}
