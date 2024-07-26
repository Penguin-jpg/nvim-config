return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  -- manage libuv types with lazy, this plugin will never be loaded
  { "Bilal2453/luvit-meta", lazy = true },
  -- add lazydev source to cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts) table.insert(opts.sources, { name = "lazydev", group_index = 0 }) end,
  },
}
