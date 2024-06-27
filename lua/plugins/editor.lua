-- Plugins that enhance editor experience
return {
  {
    "numToStr/Comment.nvim",
    opts = {
      -- Ignore empty line
      ignore = "^$",
    },
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
  },
  -- Built-in terminal support
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      -- Use powershell for toggleterm on windows
      if vim.fn.has "win32" then opts.shell = "pwsh.exe" end
    end,
  },
  -- File tagging and navigation
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      scope = "git_branch",
    },
    cmd = { "Grapple" },
    keys = {
      { "<Leader><Leader>a", "<Cmd>Grapple tag<CR>", desc = "Add tag to file" },
      { "<Leader><Leader>d", "<Cmd>Grapple untag<CR>", desc = "Delete tag from file" },
      { "<Leader><Leader>e", "<Cmd>Grapple toggle_tags<CR>", desc = "Select from tags" },
      { "<Leader><Leader>s", "<Cmd>Grapple toggle_scopes<CR>", desc = "Select a project scope" },
      { "<Leader><Leader>x", "<Cmd>Grapple reset<CR>", desc = "Clear tags" },
      { "<C-n>", "<Cmd>Grapple cycle forward<CR>", desc = "Select next tag" },
      { "<C-p>", "<Cmd>Grapple cycle backward<CR>", desc = "Select previous tag" },
    },
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
    "monkoose/neocodeium",
    event = "LspAttach",
    config = function()
      local neocodeium = require "neocodeium"
      neocodeium.setup()
      vim.keymap.set("n", "<Leader>;", function() require("neocodeium.commands").toggle() end)
      vim.keymap.set("i", "<A-a>", function() require("neocodeium").accept() end)
      vim.keymap.set("i", "<C-Right>", function() require("neocodeium").accept_word() end)
      vim.keymap.set("i", "<A-e>", function() require("neocodeium").accept_line() end)
      vim.keymap.set("i", "<S-Right>", function() require("neocodeium").cycle_or_complete() end)
      vim.keymap.set("i", "<S-Left>", function() require("neocodeium").cycle_or_complete(-1) end)
      vim.keymap.set("i", "<C-x>", function() require("neocodeium").clear() end)
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
      { "<A-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" } },
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
}
