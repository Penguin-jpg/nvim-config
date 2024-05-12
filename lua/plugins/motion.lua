-- Plugins related to motion
return {
  -- Move lines up/down/left/right
  {
    "echasnovski/mini.move",
    version = "*",
    opts = {
      mappings = {
        left = "<A-h>",
        right = "<A-l>",
        down = "<A-j>",
        up = "<A-k>",
        line_left = "<A-H>",
        line_right = "<A-L>",
        line_down = "<A-J>",
        line_up = "<A-K>",
      },
      options = {
        reindent_linewise = true,
      },
    },
  },
  -- Better move by word support
  {
    "chrisgrieser/nvim-spider",
    opts = {},
    keys = {
      { "w", "<Cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<Cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<Cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
      { "ge", "<Cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
    },
  },
  -- Faster change/delete/replace delimiter pairs
  {
    "echasnovski/mini.surround",
    opts = { n_lines = 200 },
    keys = {
      { "sa", mode = { "n", "x" }, desc = "Add surrounding" },
      { "sd", mode = { "n", "x" }, desc = "Delete surrounding" },
      { "sr", mode = { "n", "x" }, desc = "Replace surrounding" },
      { "sf", mode = { "n", "x" }, desc = "Find right surrounding" },
      { "sF", mode = { "n", "x" }, desc = "Find left surrounding" },
      { "sh", mode = { "n", "x" }, desc = "Highlight surrounding" },
      { "sn", mode = { "n", "x" }, desc = "Update `MiniSurround.config.n_lines`" },
    },
  },
  -- Better character motion support
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "gs", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" },
      { "gS", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
      { "r", function() require("flash").remote() end, mode = "o", desc = "Remote Flash" },
      { "R", function() require("flash").treesitter_search() end, mode = { "x", "o" }, desc = "Treesitter Search" },
    },
  },
}
