-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

return function(mappings)
  local core = require "astrocore"
  local is_available = core.is_available

  ------ Utility functions ------
  mappings.n["<S-a>"] = { "ggVG", desc = "Select all lines" }
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
  mappings.n["<C-Right>"] = { "<Plug>WordMotion_w", desc = "Next word" }
  mappings.n["<C-Left>"] = { "<Plug>WordMotion_b", desc = "Previous word" }
  -- Use <C-H> since <C-BS> sometimes fails (<C-H> also makes <C-BS> work)
  mappings.i["<C-H>"] = { "<C-w>", desc = { "Delete a word forward" } }
  -- <C-o> will exit insert mode tempoarily and back to insert mode again
  mappings.i["<C-Del>"] = { "<C-o>dw", desc = "Delete a word backward" }
  mappings.i["<C-z>"] = { "<C-o>u", desc = "Undo" }
  mappings.i["<C-r>"] = { "<C-o><C-r>", desc = "Redo" }
  mappings.i["<C-s>"] = { "<Cmd>w!<CR>", desc = "Save file" } 
  mappings.v["<C-c>"] = { "y", desc = "Copy selected block" }
  mappings.i["<S-Tab>"] = { "<C-d>", desc = "Unindent line" }
  -- Delete without yanking
  mappings.n["D"] = { '"_dd', desc = "Delete without yanking" }
  mappings.v["D"] = { '"_d', desc = "Delete without yanking" }
  -- <C-M> means ctrl + alt
  mappings.n["<C-M-Up>"] = { "<Cmd>resize -2<CR>", desc = "Resize split up" }
  mappings.n["<C-M-Down>"] = { "<Cmd>resize +2<CR>", desc = "Resize split down" }
  mappings.n["<C-M-Left>"] = { "<Cmd>vertical resize -2<CR>", desc = "Resize split left" }
  mappings.n["<C-M-Right>"] = { "<Cmd>vertical resize +2<CR>", desc = "Resize split right" }

  ------ Custom mappings for nvim-gomove ------
  if is_available "nvim-gomove" then
    mappings.n["<A-Up>"] = { "<Plug>GoNSMUp", desc = "Move line up" }
    mappings.n["<A-Down>"] = { "<Plug>GoNSMDown", desc = "Move line down" }
    mappings.n["<A-Left>"] = { "<Plug>GoNSMLeft", desc = "Move line left" }
    mappings.n["<A-Right>"] = { "<Plug>GoNSMRight", desc = "Move line right" }
    mappings.n["<S-Up>"] = { "<Plug>GoNSDUp", desc = "Duplicate line and paste it above" }
    mappings.n["<S-Down>"] = { "<Plug>GoNSDDown", desc = "Duplicate line and paste it below" }
    mappings.v["<A-Up>"] = { "<Plug>GoVSMUp", desc = "Move block up" }
    mappings.v["<A-Down>"] = { "<Plug>GoVSMDown", desc = "Move block down" }
    mappings.v["<A-Left>"] = { "<Plug>GoVSMLeft", desc = "Move block left" }
    mappings.v["<A-Right>"] = { "<Plug>GoVSMRight", desc = "Move block right" }
    mappings.v["<S-Up>"] = { "<Plug>GoVSDUp", desc = "Duplicate block and paste it above" }
    mappings.v["<S-Down>"] = { "<Plug>GoVSDDown", desc = "Duplicate block and paste it below" }
  end

  -- Custom mappings for multiple-cursors.nvim ------
  if is_available "multiple-cursors.nvim" then
    for key, map in pairs {
      ["<C-Down>"] = { "<Cmd>MultipleCursorsAddDown<CR>", desc = "Add a cursor down" },
      ["<C-Up>"] = { "<Cmd>MultipleCursorsAddUp<CR>", desc = "Add a cursor up" },
      ["<C-LeftMouse>"] = { "<Cmd>MultipleCursorsMouseAddDelete<CR>", desc = "Add a cursor with mouse" },
    } do
      mappings.n[key] = map
      mappings.i[key] = map
    end

    for key, map in pairs {
      ["<Leader>a"] = { "<Cmd>MultipleCursorsAddMatches<CR>", desc = "Add cursor matches" },
      -- ["<Leader>A"] = { "<Cmd>MultipleCursorsAddMatchesV<CR>", desc = "Add cursor matches in previous visual area" },
      ["<C-n>"] = { "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", desc = "Add cursor and jump to next match" },
      -- ["<Leader>cJ"] = { "<Cmd>MultipleCursorsJumpNextMatch<CR>", desc = "Move cursor to next match" },
      -- ["<Leader>cl"] = { "<Cmd>MultipleCursorsLock<CR>", desc = "Lock virtual cursors" },
    } do
      mappings.n[key] = map
      mappings.v[key] = map
    end
  end

  return mappings
end
