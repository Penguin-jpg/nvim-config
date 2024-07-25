return {
  {
    "nvimdev/indentmini.nvim",
    event = require("utils.lazy").LazyFile,
    opts = {
      char = "┃",
      exclude = {},
      minlevel = 1,
    },
  },
}
