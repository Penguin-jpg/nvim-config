-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

return function()
  local core = require "astrocore"
  local is_available = core.is_available
  local mappings = core.empty_map_table()

  ------ Disable default mappings ------
  -- Disable defaults ctrl + arrow keys
  mappings.n["<C-Left>"] = false
  mappings.n["<C-Right>"] = false
  mappings.n["<C-Up>"] = false
  mappings.n["<C-Down>"] = false
  mappings.n["<C-Left>"] = false
  mappings.n["<C-z>"] = false

  ------ Utility functions ------
  if is_available "Comment.nvim" then
    mappings.n["<C-_>"] = {
      function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Comment line",
    }
    mappings.v["<C-_>"] = {
      "<esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      desc = "Comment block",
    }
    mappings.i["<C-_>"] = {
      function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Comment line",
    }
  end

  mappings.n["<C-z>"] = { "u", desc = "Undo" }
  mappings.i["<C-z>"] = { "<C-o>u", desc = "Undo" }
  -- <C-o> will exit insert mode tempoarily and back to insert mode again
  mappings.i["<C-Del>"] = { "<C-o>dw", desc = "Delete a word backward" }
  mappings.i["<C-s>"] = { "<Cmd>w!<CR>", desc = "Save file" }
  mappings.v["<C-c>"] = { "y", desc = "Copy selected block" }
  mappings.i["<S-Tab>"] = { "<C-d>", desc = "Unindent line" }
  -- Delete without yanking
  mappings.n["D"] = { '"_dd', desc = "Delete without yanking" }
  mappings.v["D"] = { '"_d', desc = "Delete without yanking" }
  -- Move in insert mode
  mappings.i["<C-h>"] = { "<Left>", desc = "Move left in insert mode" }
  mappings.i["<C-l>"] = { "<Right>", desc = "Move right in insert mode" }
  mappings.i["<C-k>"] = { "<Up>", desc = "Move up in insert mode" }
  mappings.i["<C-j>"] = { "<Down>", desc = "Move down in insert mode" }

  -- Duplicate line/block up/down
  mappings.n["<A-K>"] = { '"ayy"aP' }
  mappings.n["<A-J>"] = { '"ayy"ap' }
  mappings.v["<A-K>"] = { '"ay"aP' }
  mappings.v["<A-J>"] = { '"ay"ap' }

  ------ Motions related to jumping or selecting ------
  for key, map in pairs {
    ["H"] = { "^", desc = "Jump to beginning of line" },
    ["L"] = { "$", desc = "Jump to end of line" },
    ["K"] = { "5k", desc = "Move up 5 lines" },
    ["J"] = { "5j", desc = "Move down 5 lines" },
    ["ga"] = { "ggVG", desc = "Select all lines" },
  } do
    mappings.n[key] = map
    mappings.v[key] = map
  end

  return mappings
end
