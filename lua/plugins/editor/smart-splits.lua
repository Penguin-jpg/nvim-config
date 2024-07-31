return {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy", -- load on very lazy for mux detection
  opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" }, ignored_buftypes = { "nofile" } },
  keys = {
    {
      "<C-h>",
      function() require("smart-splits").move_cursor_left() end,
      mode = { "n" },
      desc = "Move to left split",
    },
    {
      "<C-l>",
      function() require("smart-splits").move_cursor_right() end,
      mode = { "n" },
      desc = "Move to right split",
    },
    {
      "<C-k>",
      function() require("smart-splits").move_cursor_up() end,
      mode = { "n" },
      desc = "Move to above split",
    },
    {
      "<C-j>",
      function() require("smart-splits").move_cursor_down() end,
      mode = { "n" },
      desc = "Move to below split",
    },
    {
      "<A-Left>",
      function() require("smart-splits").resize_left() end,
      mode = { "n" },
      desc = "Resize split left",
    },
    {
      "<A-Right>",
      function() require("smart-splits").resize_right() end,
      mode = { "n" },
      desc = "Resize split right",
    },
    {
      "<A-Up>",
      function() require("smart-splits").resize_up() end,
      mode = { "n" },
      desc = "Resize split up",
    },
    {
      "<A-Down>",
      function() require("smart-splits").resize_down() end,
      mode = { "n" },
      desc = "Resize split down",
    },
  },
}
