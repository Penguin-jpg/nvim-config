return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  opts = { headerMaxWidth = 80, transient = true, },
  keys = {
    {
      "<Leader>ss",
      function() require("grug-far").open() end,
      mode = { "n" },
      desc = "Search/Replace workspace",
    },
    {
      "<Leader>sf",
      function()
        local filter = vim.bo.buftype == "" and vim.fn.expand "%" or nil
        require("grug-far").open {
          prefills = {
            paths = filter,
          },
        }
      end,
      mode = { "n" },
      desc = "Search/Replace current file",
    },
    {
      "<Leader>sF",
      function()
        local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
        require("grug-far").open {
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        }
      end,
      mode = { "n" },
      desc = "Search/Replace current filetype",
    },
    {
      "<Leader>sw",
      function()
        local current_word = vim.fn.expand "<cword>"
        if current_word ~= "" then
          require("grug-far").open {
            startCursorRow = 4,
            prefills = { search = vim.fn.expand "<cword>" },
          }
        else
          require("utils").notify("No word under cursor", vim.log.levels.WARN, { title = "Gurg-far" })
        end
      end,
      mode = { "n", "v" },
      desc = "Search/Replace current word",
    },
  },
}
