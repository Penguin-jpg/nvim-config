-- Plugins related to motion
return {
  -- Move lines up/down/left/right
  {
    "echasnovski/mini.move",
    opts = {},
    keys = {
      { "<A-h>", mode = { "n", "x" }, desc = "Move line/block left" },
      { "<A-l>", mode = { "n", "x" }, desc = "Move line/block right" },
      { "<A-j>", mode = { "n", "x" }, desc = "Move line/block down" },
      { "<A-k>", mode = { "n", "x" }, desc = "Move line/block up" },
    },
  },
  -- Faster change/delete/replace delimiter pairs
  {
    "echasnovski/mini.surround",
    opts = { n_lines = 200 },
    keys = {
      { "sa", mode = { "n", "x" }, desc = "Add surrounding" },
      { "sd", mode = { "n", "x" }, desc = "Delete surrounding" },
      { "sr", mode = { "n", "x" }, desc = "Replace surrounding" },
      { "sf", mode = { "n", "x" }, desc = "Find right surrounding" },
      { "sF", mode = { "n", "x" }, desc = "Find left surrounding" },
      { "sh", mode = { "n", "x" }, desc = "Highlight surrounding" },
      { "sn", mode = { "n", "x" }, desc = "Update `MiniSurround.config.n_lines`" },
    },
  },
  -- Brackets splitjoin
  {
    "echasnovski/mini.splitjoin",
    opts = {
      mappings = { toggle = "gs", split = "", join = "" },
    },
    keys = {
      { "gs", mode = { "n", "x" }, desc = "Toggle splitjoin" },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local i = {
        [" "] = "Whitespace",
        ['"'] = 'Balanced "',
        ["'"] = "Balanced '",
        ["`"] = "Balanced `",
        ["("] = "Balanced (",
        [")"] = "Balanced ) including white-space",
        [">"] = "Balanced > including white-space",
        ["<lt>"] = "Balanced <",
        ["]"] = "Balanced ] including white-space",
        ["["] = "Balanced [",
        ["}"] = "Balanced } including white-space",
        ["{"] = "Balanced {",
        ["?"] = "User Prompt",
        _ = "Underscore",
        a = "Argument",
        b = "Balanced ), ], }",
        c = "Class",
        d = "Digit(s)",
        e = "Word in CamelCase & snake_case",
        f = "Function",
        g = "Entire file",
        o = "Block, conditional, loop",
        q = "Quote `, \", '",
        t = "Tag",
        u = "Use/call function & method",
        U = "Use/call without dot in name",
      }
      local a = vim.deepcopy(i)
      for k, v in pairs(a) do
        a[k] = v:gsub(" including.*", "")
      end

      local ic = vim.deepcopy(i)
      local ac = vim.deepcopy(a)
      for key, name in pairs { n = "Next", l = "Last" } do
        i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
        a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
      end
      require("which-key").register {
        mode = { "o", "x" },
        i = i,
        a = a,
      }
      local ai = require "mini.ai"
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter { -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          },
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" }, -- function
          c = ai.gen_spec.treesitter { a = "@class.outer", i = "@class.inner" }, -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call { name_pattern = "[%w_]" }, -- without dot in function name
        },
      }
    end,
  },
  -- Better move by word
  {
    "chrisgrieser/nvim-spider",
    opts = {},
    keys = {
      { "w", "<Cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Spider-w" },
      { "e", "<Cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Spider-e" },
      { "b", "<Cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Spider-b" },
      { "ge", "<Cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" }, desc = "Spider-ge" },
    },
  },
  -- Duplicate line/block up/down
  {
    "hinell/duplicate.nvim",
    keys = {
      { "<A-K>", "<Cmd>LineDuplicate -1<CR>", mode = { "n" }, desc = "Duplicate line up" },
      { "<A-J>", "<Cmd>LineDuplicate +1<CR>", mode = { "n" }, desc = "Duplicate line down" },
      { "<A-K>", "<Cmd>VisualDuplicate -1<CR>", mode = { "x" }, desc = "Duplicate block up" },
      { "<A-J>", "<Cmd>VisualDuplicate +1<CR>", mode = { "x" }, desc = "Duplicate block down" },
    },
  },
  -- Better character motion
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "gj", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" },
      {
        "gJ",
        function() require("flash").treesitter() end,
        mode = { "n", "x", "o" },
        desc = "Flash Treesitter",
      },
      { "r", function() require("flash").remote() end, mode = "o", desc = "Remote Flash" },
      {
        "R",
        function() require("flash").treesitter_search() end,
        mode = { "x", "o" },
        desc = "Treesitter Search",
      },
    },
  },
}
