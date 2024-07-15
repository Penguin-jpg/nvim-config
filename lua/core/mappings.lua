-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

return function()
  local mappings = require("astrocore").empty_map_table()

  -------------------------------------------
  ------- Disable default mappings ----------
  -------------------------------------------
  mappings.n["<C-Left>"] = false
  mappings.n["<C-Right>"] = false
  mappings.n["<C-Up>"] = false
  mappings.n["<C-Down>"] = false

  -------------------------------------------
  ----------- Utility functions -------------
  -------------------------------------------
  mappings.n["<C-z>"] = { "u", desc = "Undo" }
  mappings.i["<C-z>"] = { "<C-o>u", desc = "Undo" }
  mappings.i["<C-Del>"] = { "<C-o>dw", desc = "Delete a word backward" }
  mappings.i["<C-s>"] = { "<Cmd>w!<CR>", desc = "Save file" }
  mappings.i["<S-Tab>"] = { "<C-d>", desc = "Unindent line" }
  mappings.v["<Tab>"] = { ">gv", desc = "Indent line" }
  mappings.v["<S-Tab>"] = { "<gv", desc = "Unindent line" }

  -- Separate cut and delete motion
  for key, map in pairs {
    ["d"] = { '"_d', desc = "Delete" },
    ["X"] = { "d", desc = "Cut" },
  } do
    mappings.n[key] = map
    mappings.v[key] = map
  end

  ------ Motions related to jumping or selecting ------
  for key, map in pairs {
    ["H"] = { "^", desc = "Jump to beginning of line" },
    ["L"] = { "$", desc = "Jump to end of line" },
    ["K"] = { "5k", desc = "Move up 5 lines" },
    ["J"] = { "5j", desc = "Move down 5 lines" },
  } do
    mappings.n[key] = map
    mappings.v[key] = map
  end
  mappings.n["<C-a>"] = { "ggVG", desc = "Select all lines" }

  return mappings
end
