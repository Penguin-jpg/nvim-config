return {
  "jake-stewart/multicursor.nvim",
  event = "User File",
  branch = "1.0",
  config = function()
    local mc = require "multicursor-nvim"
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { desc = desc })
    end
    mc.setup()

    map(
      { "n", "v" },
      "<C-Up>",
      function() mc.addCursor "k" end,
      "Add a cursor above"
    )
    map(
      { "n", "v" },
      "<C-Down>",
      function() mc.addCursor "j" end,
      "Add a cursor below"
    )
    map(
      { "n", "v" },
      "<C-n>",
      function() mc.matchAddCursor(1) end,
      "Add a cursor and jump to next word"
    )
    map(
      { "n", "v" },
      "<C-p>",
      function() mc.matchAddCursor(-1) end,
      "Add a cursor and jump to previous word"
    )
    map({ "n", "v" }, "<C-A>", mc.matchAllAddCursors, "Add all matches")
    map({ "n", "v" }, "<C-Left>", mc.prevCursor, "Switch to previous cursor")
    map({ "n", "v" }, "<C-Right>", mc.nextCursor, "Switch to next cursor")
    map({ "n", "v" }, "<C-x>", mc.deleteCursor, "Delete current cursor")
    map("n", "<C-LeftMouse>", mc.handleMouse, "Add a cursor with mouse")

    map("n", "<Esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        -- default <esc> handler.
      end
    end)

    map("n", "<Leader>ma", mc.alignCursors, "Align cursors")
    map("v", "<Leader>mm", mc.matchCursors, "Match new cursors by regex")
    map("v", "<Leader>ms", mc.splitCursors, "Split by regex")
    map("n", "<Leader>mr", mc.restoreCursors, "Restore deleted cursors")
    map({ "n", "v" }, "<Leader>ml", function()
      if mc.cursorsEnabled() then
        mc.disableCursors()
      else
        mc.addCursor()
      end
    end, "Lock other cursors")
    map(
      "v",
      "<Leader>mt",
      function() mc.transposeCursors(1) end,
      "Rotate content right"
    )
    map(
      "v",
      "<Leader>mT",
      function() mc.transposeCursors(-1) end,
      "Rotate content left"
    )
    map("v", "I", mc.insertVisual, "Insert for each line of selections")
    map("v", "A", mc.appendVisual, "Append for each line of selections")

    -- customize how cursors look
    vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
    vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
