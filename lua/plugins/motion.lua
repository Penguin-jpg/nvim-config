-- Plugins related to motion
return {
  -- Move lines up/down/left/right
  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        -- Move in visual mode
        left = "<A-h>",
        right = "<A-l>",
        down = "<A-j>",
        up = "<A-k>",
        -- Move in normal mode
        line_left = "<A-h>",
        line_right = "<A-l>",
        line_down = "<A-j>",
        line_up = "<A-k>",
      },
      options = {
        reindent_linewise = true,
      },
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
  -- More bracket motion support
  {
    "echasnovski/mini.bracketed",
    event = "User AstroFile",
    opts = {},
  },
  -- Better move by word support
  {
    "chrisgrieser/nvim-spider",
    opts = {},
    keys = {
      { "w",  "<Cmd>lua require('spider').motion('w')<CR>",  mode = { "n", "o", "x" }, desc = "Spider-w" },
      { "e",  "<Cmd>lua require('spider').motion('e')<CR>",  mode = { "n", "o", "x" }, desc = "Spider-e" },
      { "b",  "<Cmd>lua require('spider').motion('b')<CR>",  mode = { "n", "o", "x" }, desc = "Spider-b" },
      { "ge", "<Cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" }, desc = "Spider-ge" },
    },
  },
  -- Duplicate line/block up/down support
  {
    "hinell/duplicate.nvim",
    keys = {
      { "<A-K>", "<Cmd>LineDuplicate -1<CR>",   mode = { "n" }, desc = "Duplicate line up" },
      { "<A-J>", "<Cmd>LineDuplicate +1<CR>",   mode = { "n" }, desc = "Duplicate line down" },
      { "<A-K>", "<Cmd>VisualDuplicate -1<CR>", mode = { "x" }, desc = "Duplicate block up" },
      { "<A-J>", "<Cmd>VisualDuplicate +1<CR>", mode = { "x" }, desc = "Duplicate block down" },
    },
  },
  -- Better character motion support
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "gs", function() require("flash").jump() end,   mode = { "n", "x", "o" }, desc = "Flash" },
      {
        "gS",
        function() require("flash").treesitter() end,
        mode = { "n", "x", "o" },
        desc = "Flash Treesitter",
      },
      { "r",  function() require("flash").remote() end, mode = "o",               desc = "Remote Flash" },
      {
        "R",
        function() require("flash").treesitter_search() end,
        mode = { "x", "o" },
        desc = "Treesitter Search",
      },
    },
  },
}
