return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  event = "User File",
  specs = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  opts = {},
}
