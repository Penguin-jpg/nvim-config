return {
  "folke/trouble.nvim",
  Cmd = "Trouble",
  specs = {
    { "lewis6991/gitsigns.nvim", optional = true, opts = { trouble = true } },
  },
  opts = function(_, opts)
    local get_icon = require("utils.ui").get_icon
    local lspkind_available, lspkind = pcall(require, "lspkind")
    opts.icons = {
      indent = {
        fold_open = get_icon("files", "FoldOpened"),
        fold_closed = get_icon("files", "FoldClosed"),
      },
      folder_closed = get_icon("files", "FolderClosed"),
      folder_open = get_icon("files", "FolderOpen"),
      kinds = lspkind_available and lspkind.symbol_map,
    }
  end,
  keys = {
    {
      "<Leader>xx",
      "<Cmd>Trouble diagnostics toggle<CR>",
      mode = { "n" },
      desc = "Trobule workspace diagnostics",
    },
    {
      "<Leader>xX",
      "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
      mode = { "n" },
      desc = "Trouble buffer diagnostics",
    },
    {
      "<Leader>xt",
      "<Cmd>Trouble todo<CR>",
      mode = { "n" },
      desc = "Trouble todo",
    },
    {
      "<Leader>xs",
      "<Cmd>Trouble symbols toggle focus=false<CR>",
      mode = { "n" },
      desc = "Trouble symbols",
    },
    {
      "<Leader>xl",
      "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>",
      mode = { "n" },
      desc = "Trouble LSP definitions / references / ...",
    },
    {
      "<Leader>xL",
      "<Cmd>Trouble loclist toggle<CR>",
      mode = { "n" },
      desc = "Trouble location list",
    },
    {
      "<Leader>xQ",
      "<Cmd>Trouble qflist toggle<CR>",
      mode = { "n" },
      desc = "Trouble quickfix list",
    },
  },
}
