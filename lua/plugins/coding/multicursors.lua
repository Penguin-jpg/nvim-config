return {
  "smoka7/multicursors.nvim",
  dependencies = { "nvimtools/hydra.nvim" },
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  opts = {
    mode_keys = {
      append = "a",
      change = "c",
      extend = "e",
      insert = "i",
    },
  },
  keys = {
    {
      mode = { "n", "v" },
      "<Leader>m",
      "<Cmd>MCstart<CR>",
      desc = "Create a cursor",
    },
  },
}
