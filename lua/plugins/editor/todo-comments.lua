return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  event = "User File",
  opts = {},
  keys = {
    { "<Leader>fT", function() Snacks.picker.todo_comments() end, desc = "Find Todos" },
    { "[T", function() require("todo-comments").jump_prev() end, desc = "Previous TODO" },
    { "]T", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
  },
}
