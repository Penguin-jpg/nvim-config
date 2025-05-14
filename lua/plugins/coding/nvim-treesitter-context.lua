return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "User File",
  cmd = { "TSContextToggle" },
  opts = {},
  keys = {
    {
      "<Leader>uT",
      "<Cmd>TSContextToggle<CR>",
      desc = "Toggle treesitter context",
    },
  },
}
