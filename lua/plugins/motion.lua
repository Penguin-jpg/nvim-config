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
      { "s", desc = vim.g.icon_enabled and "󰑤 " or "".. "Surround" },
      { "sa", mode = { "n", "v" }, desc = "Add surrounding" },
      { "sd", desc = "Delete surrounding" },
      { "sf", desc = "Find right surrounding" },
      { "sF", desc = "Find left surrounding" },
      { "sr", desc = "Highlight surrounding" },
      { "sn", desc = "Replace surrounding" },
    },
  },
}
