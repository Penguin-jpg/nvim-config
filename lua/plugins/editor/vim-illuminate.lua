return {
  "RRethy/vim-illuminate",
  event = require("utils.lazy").LazyFile,
  opts = {
    delay = 200,
    min_count_to_highlight = 2,
    large_file_cutoff = 2000,
    large_file_overrides = { providers = { "lsp" } },
    should_enable = function(bufnr) return not vim.b[bufnr].large_buf end,
  },
  config = function(_, opts) require("illuminate").configure(opts) end,
  keys = {
    {
      "]r",
      function() require("illuminate")["goto_next_reference"](false) end,
      mode = { "n" },
      desc = "Next reference",
    },
    {
      "[r",
      function() require("illuminate")["goto_prev_reference"](false) end,
      mode = { "n" },
      desc = "Previous reference",
    },
    {
      "<Leader>ur",
      function() require("illuminate").toggle_buf() end,
      mode = { "n" },
      desc = "Toggle reference highlighting (buffer)",
    },
    {
      "<Leader>uR",
      function() require("illuminate").toggle() end,
      mode = { "n" },
      desc = "Toggle reference highlighting (global)",
    },
  },
}
