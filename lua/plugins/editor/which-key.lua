return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    icons = {
      group = vim.g.icons_enabled ~= false and "" or "+",
      rules = false,
      separator = "-",
    },
    spec = {
      mode = { "n", "v" },
      { "<Leader>b", group = "Buffer" },
      { "<Leader>f", group = "Find" },
      { "<Leader>g", group = "Git" },
      { "<Leader>l", group = "LSP" },
      { "<leader>t", group = "Toggle" },
      { "[", group = "Previous" },
      { "]", group = "Next" },
      { "g", group = "Goto" },
      { "z", group = "Fold" },
    },
  },
}
