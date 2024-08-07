return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>e",
        function() require("yazi").yazi() end,
        desc = "Open file manager",
      },
      {
        "<leader>E",
        function() require("yazi").yazi(nil, vim.fn.getcwd()) end,
        desc = "Open file manager in nvim's working directory",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
    },
  },
}
