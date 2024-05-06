-- Plugins that enhance editor experience
return {
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
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",  -- Use the latest tagged version
    event = "User AstroFile",
    opts = {},  -- This causes the plugin setup function to be called
    cmd = {
      "MultipleCursorsAddDown",
      "MultipleCursorsAddUp",
      "MultipleCursorsMouseAddDelete",
      "MultipleCursorsAddMatches",
      "MultipleCursorsAddMatchesV",
      "MultipleCursorsAddJumpNextMatch",
      "MultipleCursorsJumpNextMatch",
      "MultipleCursorsLock",
    },
  },
  -- Better code folding
  {
    "kevinhwang91/nvim-ufo",
    opts = {
      -- Add virtual text to show how many lines are folded
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
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
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
      end,
    },
  },
}
