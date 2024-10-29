return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "clojure", "edn" },
      root = { "project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", "bb.edn" },
    })
  end,

  -- Add Clojure & related to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "clojure" } },
  },

  -- Extend auto completion
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      "PaterJason/cmp-conjure",
    },
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        vim.list_extend(opts.sources, { name = "clojure" })
      end
    end,
  },

  -- Add s-exp mappings
  { "tpope/vim-sexp-mappings-for-regular-people" },
  { "guns/vim-sexp" },
}
