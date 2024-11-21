return {
  "otavioschwanck/arrow.nvim",
  dependencies = { { "echasnovski/mini.icons", lazy = true } },
  opts = {
    show_icons = true,
    separate_by_branch = true,
    leader_key = ";",
    buffer_leader_key = "m",
  },
  keys = {
    { ";", function() require("arrow.persist").toggle() end, desc = "Open bookmarks" },
    { "m", function() require("arrow.buffer_ui").openMenu() end, desc = "Open per buffer bookmarks" },
  },
}
