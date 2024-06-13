-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.color.nvim-highlight-colors" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.neovim-lua-development.lazydev-nvim" },
}
