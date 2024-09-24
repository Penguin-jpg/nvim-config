return {
  "brenoprata10/nvim-highlight-colors",
  event = "User File",
  cmd = "HighlightColors",
  opts = { enabled_named_colors = false },
  keys = {
    { "<Leader>tc", function() vim.cmd.HighlightColors "Toggle" end, desc = "Toggle color highlight" },
  },
}
