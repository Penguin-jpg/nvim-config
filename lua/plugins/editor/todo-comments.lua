return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  event = require("utils.lazy").LazyFile,
  specs = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  opts = {},
}
