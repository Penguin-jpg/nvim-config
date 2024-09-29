return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    icons = {
      group = vim.g.icon_enabled ~= false and "" or "+",
      rules = false,
      separator = "-",
    },
    spec = {
      mode = { "n", "v" },
      { "<Leader>b", group = "Buffer", icon = { icon = " " } },
      { "<Leader>f", group = "Find", icon = { icon = " " } },
      { "<Leader>g", group = "Git", icon = { icon = "󰊢 " } },
      { "<Leader>l", group = "LSP", icon = { icon = " " } },
      { "<Leader>m", group = "Multi-cursor", icon = { icon = "󰇀 " } },
      { "<Leader>s", group = "Search/Replace", icon = { icon = "󰛔 " } },
      { "<Leader>S", group = "Session", icon = { icon = "󰆓 " } },
      { "<leader>t", group = "Toggle", icon = { icon = "󰔡 " } },
      { "<leader>x", group = "Diagnostics/Quickfix", icon = { icon = "󰒡 " } },
      { "[", group = "Previous" },
      { "]", group = "Next" },
      { "g", group = "Goto" },
      { "gs", group = "Surround" },
      { "z", group = "Fold" },
      { "<Leader>gh", group = "Gitsigns" },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show { global = false } end,
      desc = "Buffer keymaps (which-key)",
    },
  },
}
