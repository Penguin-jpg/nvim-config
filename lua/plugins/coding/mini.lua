return {
  -- move lines up/down/left/right
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
  -- faster change/delete/replace delimiter pairs
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
  {
    "echasnovski/mini.ai",
    event = require("utils.lazy").LazyFile,
    opts = function()
      -- define custom textobjects
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
    config = function(_, opts)
      -- register to which-key
      local objects = {
        { " ", desc = "whitespace" },
        { '"', desc = '" string' },
        { "'", desc = "' string" },
        { "(", desc = "() block" },
        { ")", desc = "() block with ws" },
        { "<", desc = "<> block" },
        { ">", desc = "<> block with ws" },
        { "?", desc = "user prompt" },
        { "U", desc = "use/call without dot" },
        { "[", desc = "[] block" },
        { "]", desc = "[] block with ws" },
        { "_", desc = "underscore" },
        { "`", desc = "` string" },
        { "a", desc = "argument" },
        { "b", desc = ")]} block" },
        { "c", desc = "class" },
        { "d", desc = "digit(s)" },
        { "e", desc = "CamelCase / snake_case" },
        { "f", desc = "function" },
        { "g", desc = "entire file" },
        { "i", desc = "indent" },
        { "o", desc = "block, conditional, loop" },
        { "q", desc = "quote `\"'" },
        { "t", desc = "tag" },
        { "u", desc = "use/call" },
        { "{", desc = "{} block" },
        { "}", desc = "{} with ws" },
      }

      local ret = { mode = { "o", "x" } }
      ---@type table<string, string>
      local mappings = vim.tbl_extend("force", {}, {
        around = "a",
        inside = "i",
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
      }, opts.mappings or {})
      mappings.goto_left = nil
      mappings.goto_right = nil

      for name, prefix in pairs(mappings) do
        name = name:gsub("^around_", ""):gsub("^inside_", "")
        ret[#ret + 1] = { prefix, group = name }
        for _, obj in ipairs(objects) do
          local desc = obj.desc
          if prefix:sub(1, 1) == "i" then desc = desc:gsub(" with ws", "") end
          ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
        end
      end
      require("which-key").add(ret, { notify = false })
    end,
  },
}