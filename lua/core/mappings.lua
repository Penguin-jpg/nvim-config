-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

return function()
  local utils = require "astrocore"
  local is_available = utils.is_available
  local mappings = utils.empty_map_table()

  ------ Disable default mappings ------
  -- Disable defaults ctrl + arrow keys
  mappings.n["<C-Left>"] = false
  mappings.n["<C-Right>"] = false
  mappings.n["<C-Up>"] = false
  mappings.n["<C-Down>"] = false

  ------ Utility functions ------
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
