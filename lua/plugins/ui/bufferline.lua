return {
  "akinsho/bufferline.nvim",
  event = require("utils.lazy").LazyFile,
  keys = {
    { "<Leader>bp", "<Cmd>BufferLinePick<CR>", desc = "Pick a buffer" },
    { "<Leader>bc", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
    { "<Leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<Leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<b", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer to left" },
    { ">b", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer to right" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      diagnostics_indicator = function(_, _, diag)
        local get_icon = require("utils.icons").get_icon
        local ret = (diag.error and get_icon("diagnostic", "Error") .. " " .. diag.error .. " " or "")
          .. (diag.warning and get_icon("diagnostic", "Warn") .. " " .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
      indicator = {
        style = "underline",
      },
    },
  },
}
