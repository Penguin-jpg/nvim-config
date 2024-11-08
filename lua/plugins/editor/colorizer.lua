return {
  "brenoprata10/nvim-highlight-colors",
  event = "User File",
  cmd = "HighlightColors",
  opts = {
    render = "virtual",
    virtual_symbol = "⬤",
    enabled_named_colors = false,
    enabled_tailwind = false,
  },
  keys = {
    { "<Leader>tc", function() vim.cmd.HighlightColors "Toggle" end, desc = "Toggle color highlight" },
  },
}
