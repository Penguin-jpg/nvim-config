local get_icon = require("utils.ui").get_icon
local get_header = require("utils.ui").get_header

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        keys = {
          {
            icon = " ",
            key = "e",
            action = ":Oil",
            desc = "File Explorer",
          },
          { icon = get_icon("FileDefault", 1), key = "n", action = ":ene", desc = "New File" },
          { icon = " ", key = "f", action = ":lua Snacks.dashboard.pick('files')", desc = "Find File" },
          {
            icon = "󱎸 ",
            key = "w",
            action = ":lua Snacks.dashboard.pick('live_grep')",
            desc = "Find Text",
          },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "S", desc = "Load Session", action = ":lua require('persistence').load()" },
          { icon = " ", key = "q", action = ":qa", desc = "Quit" },
        },
        header = get_header("OH", 0, 0),
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
