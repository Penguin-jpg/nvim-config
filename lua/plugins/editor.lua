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
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("hlchunk").setup(require("astrocore").extend_tbl(opts, {
        chunk = {
          enable = true,
          notify = false,
          chars = {
            horizontal_line = "━",
            vertical_line = "┃",
            left_top = "┏",
            left_bottom = "┗",
            right_arrow = "➤",
          },
        },
        indent = {
          enable = true,
        },
        blank = {
          enable = false,
        },
        line_num = {
          enable = true,
        },
      }))
    end,
  },
  -- Rainbow delimiters support
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "User AstroFile",
    main = "rainbow-delimiters.setup",
    opts = {},
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
        "<Leader>R",
        function() require("grug-far").grug_far { prefills = { search = vim.fn.expand "<cword>" } } end,
        mode = { "n" },
        desc = "Open GrugFar",
      },
    },
  },
  -- Dynamic colorcolumn
  {
    "Bekaboo/deadcolumn.nvim",
    event = "User AstroFile",
    opts = {},
  },
  -- Smooth scrolling
  {
    "echasnovski/mini.animate",
    event = "User AstroFile",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs { "Up", "Down" } do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require "mini.animate"
      return {
        resize = {
          timing = animate.gen_timing.linear { duration = 100, unit = "total" },
        },
        scroll = {
          timing = animate.gen_timing.linear { duration = 150, unit = "total" },
          subscroll = animate.gen_subscroll.equal {
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          },
        },
        cursor = {
          timing = animate.gen_timing.linear { duration = 80, unit = "total" },
        },
      }
    end,
  },
  -- Show available word motions under code
  {
    "tris203/precognition.nvim",
    event = "User AstroFile",
    opts = {
      hints = {
        Caret = { text = "H", prio = 2 },
        Dollar = { text = "L", prio = 1 },
        MatchingPair = { text = "%", prio = 5 },
        Zero = { text = "0", prio = 1 },
        w = { text = "w", prio = 10 },
        b = { text = "b", prio = 9 },
        e = { text = "e", prio = 8 },
        W = { text = "W", prio = 7 },
        B = { text = "B", prio = 6 },
        E = { text = "E", prio = 5 },
      },
    },
  },
}
