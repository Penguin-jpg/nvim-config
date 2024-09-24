return {
  "onsails/lspkind.nvim",
  lazy = true,
  enabled = vim.g.icons_enabled ~= false,
  opts = {
    mode = "symbol",
    symbol_map = require("utils.ui").get_icon("kind", nil),
    menu = {},
  },
  config = function(_, opts) require("lspkind").init(opts) end,
}
