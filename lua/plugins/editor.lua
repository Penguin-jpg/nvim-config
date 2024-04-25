-- Plugins that enhance editor experience
return {
  -- TODO comment support (already installed in AstroNvim v4)
  -- {
  --   "folke/todo-comments.nvim",
  --   event = "User AstroFile",
  --   opts = {},
  -- },
  -- Bracket pair colorize
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "User AstroFile",
    config = function(_, opts) require "rainbow-delimiters.setup"(opts) end,
  },
  -- Better indent blankline
  {
    "shellRaining/hlchunk.nvim",
    event = "User AstroFile",
    config = function()
      require("hlchunk").setup {
        -- Disable line number and blank highlight
        line_num = {
          enable = false,
        },
        blank = {
          enable = false,
        },
      }
    end,
  },
  -- Semantic tokens highlight 
  {
    "m-demare/hlargs.nvim",
    event = "User AstroFile",
    opts = {
      color = "#ea7183",
      paint_arg_usages = true,
    },
  },
  -- Transparent background
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      -- table: default groups
      groups = {
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLineNr",
        "EndOfBuffer",
      },
      -- table: additional groups that should be cleared
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "NeoTreeNormal",
        "NeoTreeFloatBorder",
        "NeoTreeNormalNC",
      },
      -- table: groups you don't want to clear
      exclude_groups = {},
    },
    keys = {
      { "<leader>uT", "<cmd>TransparentToggle<CR>", desc = "Toggle transparency" },
    },
  },
  -- Diagnostics list
  {
    "folke/trouble.nvim",
    event = "User AstroFile",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
      action_keys = {
        close = { "q", "<esc>" },
        cancel = "<c-e>",
      },
    },
  },
  -- AI code completion
  {
    "Exafunction/codeium.vim",
    event = "User AstroFile",
    config = function()
      vim.keymap.set("i", "<S-Tab>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
      vim.keymap.set(
        "i",
        "<S-Right>",
        function() return vim.fn["codeium#CycleCompletions"](1) end,
        { expr = true, silent = true }
      )
      vim.keymap.set(
        "i",
        "<S-Left>",
        function() return vim.fn["codeium#CycleCompletions"](-1) end,
        { expr = true, silent = true }
      )
      vim.keymap.set("i", "<C-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
      vim.keymap.set("n", "<leader>;", function()
        if vim.g.codeium_enabled == true then
          vim.cmd "CodeiumDisable"
        else
          vim.cmd "CodeiumEnable"
        end
      end, { noremap = true, desc = "Toggle Codeium active" })
    end,
  },
  -- Multi-cursors support
  {
    "mg979/vim-visual-multi",
    event = "User AstroFile",
  },
}
