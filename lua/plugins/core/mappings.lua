-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

function extend_mappings(mappings)
  local core = require "astrocore"
  local is_available = core.is_available
  local maps = core.empty_map_table()

  -- tables with the `name` key will be registered with which-key if it's installed
  -- this is useful for naming menus
  maps.n["<leader>b"] = { name = "Buffers" }
  maps.n["<Leader>bD"] = {
    function()
      require("astroui.status.heirline").buffer_picker(
        function(bufnr) require("astrocore.buffer").close(bufnr) end
      )
    end,
    desc = "Pick to close",
  }

  ------ Utility functions ------
  maps.n["<C-a>"] = { "ggVG", desc = "Select all lines" }
  if is_available "Comment.nvim" then
    maps.n["<C-_>"] = {
      function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Comment line",
    }
    maps.v["<C-_>"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      desc = "Comment block",
    }
    maps.i["<C-_>"] = {
      function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Comment line",
    }
  end
  maps.n["<C-z>"] = { "u", desc = "Undo" }
  maps.n["<C-Right>"] = { "<Plug>WordMotion_w", desc = "Next word" }
  maps.n["<C-Left>"] = { "<Plug>WordMotion_b", desc = "Previous word" }
  -- Use <C-H> since <C-BS> sometimes fails (<C-H> also makes <C-BS> work)
  maps.i["<C-H>"] = { "<C-w>", desc = { "Delete a word forward" } }
  -- <C-o> will exit insert mode tempoarily and back to insert mode again
  maps.i["<C-Del>"] = { "<C-o>dw", desc = "Delete a word backward" }
  maps.i["<C-z>"] = { "<C-o>u", desc = "Undo" }
  maps.i["<C-r>"] = { "<C-o><C-r>", desc = "Redo" }
  maps.i["<C-s>"] = { "<cmd>w!<cr>", desc = "Save file" } 
  maps.v["<C-c>"] = { "y", desc = "Copy selected block" }
  maps.i["<S-Tab>"] = { "<C-d>", desc = "Unindent line" }
  -- Delete without yanking
  maps.n["D"] = { '"_dd', desc = "Delete without yanking" }
  maps.v["D"] = { '"_d', desc = "Delete without yanking" }

  -- Custom mappings for nvim-notify
  if is_available "nvim-notify" then
    maps.n["<leader>un"] = {
      function() require("notify").dismiss { silent = true, pending = true } end,
      desc = "Dismiss all notifications",
    }
  end

  ------ Custom mappings for nvim-gomove ------
  if is_available "nvim-gomove" then
    maps.n["<A-Up>"] = { "<Plug>GoNSMUp", desc = "Move line up" }
    maps.n["<A-Down>"] = { "<Plug>GoNSMDown", desc = "Move line down" }
    maps.n["<A-Left>"] = { "<Plug>GoNSMLeft", desc = "Move line left" }
    maps.n["<A-Right>"] = { "<Plug>GoNSMRight", desc = "Move line right" }
    maps.n["<S-Up>"] = { "<Plug>GoNSDUp", desc = "Duplicate line and paste it above" }
    maps.n["<S-Down>"] = { "<Plug>GoNSDDown", desc = "Duplicate line and paste it below" }
    maps.v["<A-Up>"] = { "<Plug>GoVSMUp", desc = "Move block up" }
    maps.v["<A-Down>"] = { "<Plug>GoVSMDown", desc = "Move block down" }
    maps.v["<A-Left>"] = { "<Plug>GoVSMLeft", desc = "Move block left" }
    maps.v["<A-Right>"] = { "<Plug>GoVSMRight", desc = "Move block right" }
    maps.v["<S-Up>"] = { "<Plug>GoVSDUp", desc = "Duplicate block and paste it above" }
    maps.v["<S-Down>"] = { "<Plug>GoVSDDown", desc = "Duplicate block and paste it below" }
  end

  ------ Custom mappings for substitution.nvim ------
  if is_available "substitute.nvim" then
    local replace_icon = vim.g.icon_enabled and "⟺ " or ""
    maps.n["<leader>s"] = { desc = replace_icon .. "Substitute" }
    maps.n["<leader>sv"] = {
      function() require("substitute").line() end,
      desc = "Replace line with register value",
    }
    -- maps.n["<leader>re"] = {
    --   function() require("substitute").eol() end,
    --   desc = "Replace from cursor to eol with register value",
    -- }
    maps.n["<leader>sr"] = {
      function() require("substitute.range").operator { subject = { motion = "iw" }, range = { motion = "ap" } } end,
      desc = "Replace matched words with input value",
    }
    maps.n["<leader>sa"] = {
      function() require("substitute.range").operator { subject = { motion = "iw" }, range = "%" } end,
      desc = "Replace all matched words with input value",
    }
    maps.v["<leader>sv"] = {
      function() require("substitute").visual() end,
      desc = "Replace selected block with register value",
    }
    maps.v["<leader>sr"] = {
      function() require("substitute.range").visual { subject = { motion = "iw" }, range = { motion = "ap" } } end,
      desc = "Replace matched words with input value",
    }
    maps.v["<leader>sa"] = {
      function() require("substitute.range").visual { subject = { motion = "iw" }, range = "%" } end,
      desc = "Replace all matched words with input value",
    }
  end

  ------ Custom mappings for trouble.nvim ------
  if is_available "trouble.nvim" then
    local trouble_icon = vim.g.icon_enabled and "󱍼 " or ""
    maps.n["<leader>x"] = { desc = trouble_icon .. "Trouble" }
    maps.n["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
    maps.n["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
    maps.n["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" }
    maps.n["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" }
  end

  -- Terminal mode
  -- setting a mapping to false will disable it
  -- maps.t["<esc>"] = false

  core.extend_tbl(mappings, maps)
end