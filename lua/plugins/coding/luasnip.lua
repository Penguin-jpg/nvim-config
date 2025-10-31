-- snippet engine
return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  lazy = true,
  build = vim.fn.has "win32" == 0
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
    or nil,
  dependencies = { { "rafamadriz/friendly-snippets", lazy = true } },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
    region_check_events = "CursorMoved",
  },
  config = function(_, opts)
    require("luasnip").config.setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load { paths = { vim.fn.stdpath "config" .. "/snippets" } }
  end,
}
