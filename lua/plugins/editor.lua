-- Plugins that enhance editor experience
return {
  -- Built-in terminal support
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      -- Use powershell for toggleterm on windows
      if vim.fn.has "win32" then opts.shell = "pwsh.exe" end
    end,
  },
  -- Better escape support
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jj", "kk", "jk" },
    },
  },
  -- Better indent blankline
  {
    "shellRaining/hlchunk.nvim",
    event = "User AstroFile",
    config = function()
      require("hlchunk").setup {
        chunk = {
          notify = false,
        },
        blank = {
          enable = false,
        },
        line_num = {
          use_treesitter = true,
        },
      }
    end,
  },
  -- Rainbow delimiters support
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "User AstroFile",
    main = "rainbow-delimiters.setup",
    opts = {},
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
  -- AI code completion
  {
    "Exafunction/codeium.vim",
    event = "LspAttach",
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
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = {},
    keys = {
      { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" } },
      { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" } },
      { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" } },
      { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" } },
      { "<C-n>", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" } },
    },
  },
  -- Better code folding
  {
    "kevinhwang91/nvim-ufo",
    opts = {
      -- Add virtual text to show how many lines are folded
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    },
  },
  -- Tmux integration
  {
    "aserowy/tmux.nvim",
    opts = {
      resize = {
        enable_default_keybindings = false,
      },
    },
    keys = {
      { "<A-Left>", "<Cmd>lua require('tmux').resize_left()<CR>", mode = { "n" } },
      { "<A-Right>", "<Cmd>lua require('tmux').resize_right()<CR>", mode = { "n" } },
      { "<A-Down>", "<Cmd>lua require('tmux').resize_bottom()<CR>", mode = { "n" } },
      { "<A-Up>", "<Cmd>lua require('tmux').resize_top()<CR>", mode = { "n" } },
    },
  },
  -- Find and replace
  {
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
  },
  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup {
        hide_cursor = false,
      }
    end,
  },
}
