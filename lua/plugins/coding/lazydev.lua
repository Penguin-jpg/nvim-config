-- lua source
return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  specs = {
    -- manage libuv types with lazy, this plugin will never be loaded
    { "Bilal2453/luvit-meta", lazy = true },
  },
  opts = {
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      { path = "lazy.nvim", words = { "Lazy" } },
    },
  },
}
