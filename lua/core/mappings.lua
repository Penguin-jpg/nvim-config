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

  mappings.n["<C-Z>"] = { "u", desc = "Undo" }
  mappings.i["<C-Z>"] = { "<C-o>u", desc = "Undo" }
  -- Use <C-H> since <C-BS> sometimes fails (<C-H> also makes <C-BS> work)
  mappings.i["<C-H>"] = { "<C-w>", desc = "Delete a word forward" }
  -- <C-o> will exit insert mode tempoarily and back to insert mode again
  mappings.i["<C-Del>"] = { "<C-o>dw", desc = "Delete a word backward" }
  mappings.i["<C-s>"] = { "<Cmd>w!<CR>", desc = "Save file" } 
  mappings.v["<C-c>"] = { "y", desc = "Copy selected block" }
  mappings.i["<S-Tab>"] = { "<C-d>", desc = "Unindent line" }
  -- Delete without yanking
  mappings.n["D"] = { '"_dd', desc = "Delete without yanking" }
  mappings.v["D"] = { '"_d', desc = "Delete without yanking" }

  ------ Motions to duplicate line or block up/down ------
  mappings.n["<A-K>"] = {"<Cmd>co.-1<CR>"}
  mappings.n["<A-J>"] = {"<Cmd>co.<CR>"}
  mappings.v["<A-J>"] = {"<Cmd>co.<CR>"}

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
