return {
  "jackMort/ChatGPT.nvim",
  lazy = true,
  cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions", "ChatGPTRun" },
  config = function()
    local secrets_file = vim.fn.expand("~/.secrets.rc")
    require("chatgpt").setup({
      api_key_cmd = "grab-secret " .. secrets_file .. " OPENAI_API_KEY",
      openai_params = {
        model = "gpt-4o",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
      },
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
