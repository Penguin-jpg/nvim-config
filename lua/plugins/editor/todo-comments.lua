return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  event = "User File",
  opts = {},
  keys = {
    { "[T", function() require("todo-comments").jump_prev() end, desc = "Previous TODO" },
    { "]T", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
  },
}
