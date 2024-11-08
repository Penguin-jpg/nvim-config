return {
  {
    "rcarriga/nvim-notify",
    lazy = true,
    depenedencies = { { "nvim-lua/plenary.nvim", lazy = true } },
    opts = {
      stages = "static",
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
      on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 100 }) end,
    },
    keys = {
      {
        "<Leader>td",
        function() require("notify").dismiss { pending = true, silent = true } end,
        mode = { "n" },
        desc = "Dismiss notifications",
      },
      {
        "<Leader>fn",
        "<Cmd>Telescope notify<CR>",
        mode = { "n" },
        desc = "Find notifications",
      },
    },
  },
}
