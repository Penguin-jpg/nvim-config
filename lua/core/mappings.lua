-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

return function(mappings)
  local core = require "astrocore"
  local is_available = core.is_available

  ------ Utility functions ------
  mappings.n["<C-a>"] = { "ggVG", desc = "Select all lines" }
  if is_available "Comment.nvim" then
    mappings.n["<C-_>"] = {
      function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Comment line",
    }
    mappings.v["<C-_>"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
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
  mappings.t["<C-H>"] = false -- disable the original <C-H> function
  mappings.t["<C-H>"] = { "<C-w>", desc = { "Delete a word forward" } }
  -- <C-o> will exit insert mode tempoarily and back to insert mode again
  mappings.i["<C-Del>"] = { "<C-o>dw", desc = "Delete a word backward" }
  mappings.i["<C-z>"] = { "<C-o>u", desc = "Undo" }
  mappings.i["<C-r>"] = { "<C-o><C-r>", desc = "Redo" }
  mappings.i["<C-s>"] = { "<cmd>w!<cr>", desc = "Save file" } 
  mappings.v["<C-c>"] = { "y", desc = "Copy selected block" }
  mappings.i["<S-Tab>"] = { "<C-d>", desc = "Unindent line" }
  -- Delete without yanking
  mappings.n["D"] = { '"_dd', desc = "Delete without yanking" }
  mappings.v["D"] = { '"_d', desc = "Delete without yanking" }

  -- Custom mappings for nvim-notify
  if is_available "nvim-notify" then
    mappings.n["<leader>un"] = {
      function() require("notify").dismiss { silent = true, pending = true } end,
      desc = "Dismiss all notifications",
    }
  end

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

  ------ Custom mappings for substitution.nvim ------
  if is_available "substitute.nvim" then
    local replace_icon = vim.g.icon_enabled and "⟺ " or ""
    mappings.n["<leader>s"] = { desc = replace_icon .. "Substitute" }
    mappings.n["<leader>sv"] = {
      function() require("substitute").line() end,
      desc = "Replace line with register value",
    }
    -- mappings.n["<leader>re"] = {
    --   function() require("substitute").eol() end,
    --   desc = "Replace from cursor to eol with register value",
    -- }
    mappings.n["<leader>sr"] = {
      function() require("substitute.range").operator { subject = { motion = "iw" }, range = { motion = "ap" } } end,
      desc = "Replace matched words with input value",
    }
    mappings.n["<leader>sa"] = {
      function() require("substitute.range").operator { subject = { motion = "iw" }, range = "%" } end,
      desc = "Replace all matched words with input value",
    }
    mappings.v["<leader>sv"] = {
      function() require("substitute").visual() end,
      desc = "Replace selected block with register value",
    }
    mappings.v["<leader>sr"] = {
      function() require("substitute.range").visual { subject = { motion = "iw" }, range = { motion = "ap" } } end,
      desc = "Replace matched words with input value",
    }
    mappings.v["<leader>sa"] = {
      function() require("substitute.range").visual { subject = { motion = "iw" }, range = "%" } end,
      desc = "Replace all matched words with input value",
    }
  end

  ------ Custom mappings for trouble.nvim ------
  if is_available "trouble.nvim" then
    local trouble_icon = vim.g.icon_enabled and "󱍼 " or ""
    mappings.n["<leader>x"] = { desc = trouble_icon .. "Trouble" }
    mappings.n["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
    mappings.n["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
    mappings.n["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" }
    mappings.n["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" }
  end

  return mappings
end