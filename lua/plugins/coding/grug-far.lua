return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  config = function()
    require("grug-far").setup {
      windowCreationCommand = "tabnew",
    }
  end,
  keys = {
    {
      "<Leader>r",
      function() require("grug-far").grug_far { prefills = { search = vim.fn.expand "<cword>" } } end,
      mode = { "n" },
      desc = "Open GrugFar",
    },
  },
}
