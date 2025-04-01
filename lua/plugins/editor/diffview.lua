return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewLog",
    "DiffviewFileHistory",
    "DiffviewFocusFile",
    "DiffviewRefresh",
    "DiffviewToggleFiles",
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { winbar_info = true },
      file_history = { winbar_info = true },
    },
    hooks = { diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end },
  },
  keys = { { "<Leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "Open Diffview" } },
}
