return {
  "numToStr/Comment.nvim",
  opts = function(_, opts)
    opts.ignore = "^$" -- ignore empty line

    local commentstring_avail, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
    if commentstring_avail then opts.pre_hook = commentstring.create_pre_hook() end
  end,
  keys = {
    {
      "<C-_>",
      function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
      mode = { "n", "i" },
      desc = "Comment line",
    },
    {
      "<C-_>",
      "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      mode = { "v" },
      desc = "Comment block",
    },
  },
}
