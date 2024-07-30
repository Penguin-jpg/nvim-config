return {
  "chrishrb/gx.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  config = true,
  submodules = false, -- not needed, submodules are required only for tests
  cmd = { "Browse" },
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
}
