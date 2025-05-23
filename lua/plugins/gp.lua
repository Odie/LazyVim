return {
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = { "robitx/gp.nvim" },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     table.insert(opts.sources, { name = "gp_completion" })
  --   end,
  -- },

  {
    "robitx/gp.nvim",
    dir = "~/dev/nvim/gp.nvim",
    cmd = {
      "GpChatNew",
      "GpChatPaste",
      "GpChatToggle",
      "GpChatFinder",
      "GpChatRespond",
      "GpChatDelete",
      "GpContext",
      "GpReferenceCurrentFunction",
    },
    dependencies = { "hrsh7th/nvim-cmp", "kkharji/sqlite.lua", "nvim-lua/plenary.nvim" },

    -- lazy = false,
    -- event = "VeryLazy",

    config = function()
      local conf = {
        -- Please start with minimal config possible.
        -- Just openai_api_key if you don't have OPENAI_API_KEY env set up.
        -- Defaults change over time to improve things, options might get deprecated.
        -- It's better to change only things where the default doesn't fit your needs.

        -- required openai api key (string or table with command and arguments)
        -- openai_api_key = { "cat", "path_to/openai_api_key" },
        -- openai_api_key = { "bw", "get", "password", "OPENAI_API_KEY" },
        -- openai_api_key: "sk-...",
        -- openai_api_key = os.getenv("env_name.."),
        openai_api_key = os.getenv("OPENAI_API_KEY"),

        -- at least one working provider is required
        -- to disable a provider set it to empty table like openai = {}
        providers = {
          -- secrets can be strings or tables with command and arguments
          -- secret = { "cat", "path_to/openai_api_key" },
          -- secret = { "bw", "get", "password", "OPENAI_API_KEY" },
          -- secret : "sk-...",
          -- secret = os.getenv("env_name.."),
          openai = {
            disable = false,
            endpoint = "https://api.openai.com/v1/chat/completions",
            -- secret = os.getenv("OPENAI_API_KEY"),
          },
          azure = {
            disable = true,
            endpoint = "https://$URL.openai.azure.com/openai/deployments/{{model}}/chat/completions",
            secret = os.getenv("AZURE_API_KEY"),
          },
          copilot = {
            disable = true,
            endpoint = "https://api.githubcopilot.com/chat/completions",
            secret = {
              "bash",
              "-c",
              "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
            },
          },
          ollama = {
            disable = false,
            endpoint = "http://localhost:11434/v1/chat/completions",
            secret = "",
          },
          lmstudio = {
            disable = true,
            endpoint = "http://localhost:1234/v1/chat/completions",
          },
          googleai = {
            disable = true,
            endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
            secret = os.getenv("GOOGLEAI_API_KEY"),
          },
          pplx = {
            disable = true,
            endpoint = "https://api.perplexity.ai/chat/completions",
            secret = os.getenv("PPLX_API_KEY"),
          },
          anthropic = {
            disable = false,
            endpoint = "https://api.anthropic.com/v1/messages",
            secret = os.getenv("ANTHROPIC_API_KEY"),
          },
        },

        -- prefix for all commands
        cmd_prefix = "Gp",
        -- optional curl parameters (for proxy, etc.)
        -- curl_params = { "--proxy", "http://X.X.X.X:XXXX" }
        curl_params = {},

        -- log	file location
        log_file = vim.fn.stdpath("log"):gsub("/$", "") .. "/gp.nvim.log",

        -- directory for persisting state dynamically changed by user (like model or persona)
        state_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/persisted",

        -- default command agents (model + persona)
        -- name, model and system_prompt are mandatory fields
        -- to use agent for chat set chat = true, for command set command = true
        -- to remove some default agent completely set it like:
        -- agents = {  { name = "ChatGPT3-5", disable = true, }, ... },
        agents = {
          {
            name = "ExampleDisabledAgent",
            disable = true,
          },
          {
            name = "ChatGPT4o",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
          {
            provider = "openai",
            name = "ChatGPT4o-mini",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
          {
            provider = "copilot",
            name = "ChatCopilot",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
          {
            provider = "googleai",
            name = "ChatGemini",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gemini-pro", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
          {
            provider = "pplx",
            name = "ChatPerplexityMixtral",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "mixtral-8x7b-instruct", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
          {
            provider = "anthropic",
            name = "ChatClaude-3-5-Sonnet",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "claude-3-5-sonnet-20240620", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
          {
            provider = "anthropic",
            name = "ChatClaude-3-Haiku",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "claude-3-haiku-20240307", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
          {
            provider = "ollama",
            name = "ChatOllamaLlama3",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = {
              model = "llama3",
              num_ctx = 8192,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.",
          },
          {
            provider = "ollama",
            name = "ChatOllamaLlama3-1",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = {
              model = "llama3.1",
              num_ctx = 8192,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.",
          },
          {
            provider = "lmstudio",
            name = "ChatLMStudio",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = {
              model = "dummy",
              temperature = 0.97,
              top_p = 1,
              num_ctx = 8192,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.",
          },
          {
            provider = "openai",
            name = "CodeGPT4o",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").code_system_prompt,
          },
          {
            provider = "openai",
            name = "CodeGPT4o-mini",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4o-mini", temperature = 0.7, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "Please return ONLY code snippets.\nSTART AND END YOUR ANSWER WITH:\n\n```",
          },
          {
            provider = "copilot",
            name = "CodeCopilot",
            chat = false,
            command = true,
            -- string with the Copilot engine name or table with engine name and parameters if applicable
            model = { model = "gpt-4", temperature = 0.8, top_p = 1, n = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").code_system_prompt,
          },
          {
            provider = "googleai",
            name = "CodeGemini",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gemini-pro", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").code_system_prompt,
          },
          {
            provider = "pplx",
            name = "CodePerplexityMixtral",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "mixtral-8x7b-instruct", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").code_system_prompt,
          },
          {
            provider = "anthropic",
            name = "CodeClaude-3-5-Sonnet",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "claude-3-5-sonnet-20240620", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").code_system_prompt,
          },
          {
            provider = "anthropic",
            name = "CodeClaude-3-Haiku",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "claude-3-haiku-20240307", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").code_system_prompt,
          },
          {
            provider = "ollama",
            name = "CodeOllamaLlama3",
            chat = false,
            command = true,
            -- string with the Copilot engine name or table with engine name and parameters if applicable
            model = {
              model = "llama3",
              temperature = 1.9,
              top_p = 1,
              num_ctx = 8192,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are an AI working as a code editor providing answers.\n\n"
              .. "Use 4 SPACES FOR INDENTATION.\n"
              .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
              .. "START AND END YOUR ANSWER WITH:\n\n```",
          },
          {
            provider = "ollama",
            name = "CodeOllamaLlama3-1",
            chat = false,
            command = true,
            -- string with the Copilot engine name or table with engine name and parameters if applicable
            model = {
              model = "llama3.1",
              temperature = 1.9,
              top_p = 1,
              num_ctx = 8192,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are an AI working as a code editor providing answers.\n\n"
              .. "Use 4 SPACES FOR INDENTATION.\n"
              .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
              .. "START AND END YOUR ANSWER WITH:\n\n```",
          },
        },

        -- directory for storing chat files
        chat_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/chats",
        -- chat user prompt prefix
        chat_user_prefix = "💬:",
        -- chat assistant prompt prefix (static string or a table {static, template})
        -- first string has to be static, second string can contain template {{agent}}
        -- just a static string is legacy and the [{{agent}}] element is added automatically
        -- if you really want just a static string, make it a table with one element { "🤖:" }
        chat_assistant_prefix = { "🤖:", "[{{agent}}]" },
        -- The banner shown at the top of each chat file.
        chat_template = require("gp.defaults").chat_template,
        -- if you want more real estate in your chat files and don't need the helper text
        -- chat_template = require("gp.defaults").short_chat_template,
        -- chat topic generation prompt
        chat_topic_gen_prompt = "Summarize the topic of our conversation above"
          .. " in two or three words. Respond only with those words.",
        -- chat topic model (string with model name or table with model name and parameters)
        -- explicitly confirm deletion of a chat file
        chat_confirm_delete = true,
        -- conceal model parameters in chat
        chat_conceal_model_params = true,
        -- local shortcuts bound to the chat buffer
        -- (be careful to choose something which will work across specified modes)
        chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
        chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
        chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
        chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },
        -- default search term when using :GpChatFinder
        chat_finder_pattern = "topic ",
        -- if true, finished ChatResponder won't move the cursor to the end of the buffer
        chat_free_cursor = true,
        -- use prompt buftype for chats (:h prompt-buffer)
        chat_prompt_buf_type = false,

        -- how to display GpChatToggle or GpContext: popup / split / vsplit / tabnew
        toggle_target = "vsplit",

        -- styling for chatfinder
        -- border can be "single", "double", "rounded", "solid", "shadow", "none"
        style_chat_finder_border = "single",
        -- margins are number of characters or lines
        style_chat_finder_margin_bottom = 8,
        style_chat_finder_margin_left = 1,
        style_chat_finder_margin_right = 2,
        style_chat_finder_margin_top = 2,
        -- how wide should the preview be, number between 0.0 and 1.0
        style_chat_finder_preview_ratio = 0.5,

        -- styling for popup
        -- border can be "single", "double", "rounded", "solid", "shadow", "none"
        style_popup_border = "single",
        -- margins are number of characters or lines
        style_popup_margin_bottom = 8,
        style_popup_margin_left = 1,
        style_popup_margin_right = 2,
        style_popup_margin_top = 2,
        style_popup_max_width = 160,

        -- command config and templates below are used by commands like GpRewrite, GpEnew, etc.
        -- command prompt prefix for asking user for input (supports {{agent}} template variable)
        command_prompt_prefix_template = "🤖 {{agent}} ~ ",
        -- auto select command response (easier chaining of commands)
        -- if false it also frees up the buffer cursor for further editing elsewhere
        command_auto_select_response = true,

        -- templates
        template_selection = "I have the following from {{filename}}:"
          .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
        template_rewrite = "I have the following from {{filename}}:"
          .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
          .. "\n\nRespond exclusively with the snippet that should replace the selection above.",
        template_append = "I have the following from {{filename}}:"
          .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
          .. "\n\nRespond exclusively with the snippet that should be appended after the selection above.",
        template_prepend = "I have the following from {{filename}}:"
          .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
          .. "\n\nRespond exclusively with the snippet that should be prepended before the selection above.",
        template_command = "{{command}}",

        -- example hook functions (see Extend functionality section in the README)
        hooks = {
          InspectPlugin = function(plugin, params)
            local bufnr = vim.api.nvim_create_buf(false, true)
            local copy = vim.deepcopy(plugin)
            local key = copy.config.openai_api_key or ""
            copy.config.openai_api_key = key:sub(1, 3) .. string.rep("*", #key - 6) .. key:sub(-3)
            for provider, _ in pairs(copy.providers) do
              local s = copy.providers[provider].secret
              if s and type(s) == "string" then
                copy.providers[provider].secret = s:sub(1, 3) .. string.rep("*", #s - 6) .. s:sub(-3)
              end
            end
            local plugin_info = string.format("Plugin structure:\n%s", vim.inspect(copy))
            local params_info = string.format("Command params:\n%s", vim.inspect(params))
            local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
            vim.api.nvim_win_set_buf(0, bufnr)
          end,

          -- GpImplement rewrites the provided selection/range based on comments in it
          Implement = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please rewrite this according to the contained instructions."
              .. "\n\nRespond exclusively with the snippet that should replace the selection above."

            local agent = gp.get_command_agent()
            gp.logger.info("Implementing selection with agent: " .. agent.name)

            gp.Prompt(
              params,
              gp.Target.rewrite,
              agent,
              template,
              nil, -- command will run directly without any prompting for user input
              nil -- no predefined instructions (e.g. speech-to-text from Whisper)
            )
          end,
        },
      }

      require("gp").setup(conf)
    end,
  },
}
