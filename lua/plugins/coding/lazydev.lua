-- lua source
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim", words = { "Lazy" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "astrolsp", words = { "AstroLSP" } },
        { path = "nvim-lspconfig", words = { "lspconfig.settings" } },
      },
    },
  },
  -- add lazydev to your completion providers
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },
        },
      },
    },
  },
}
