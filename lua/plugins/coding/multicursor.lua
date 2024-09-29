return {
  "jake-stewart/multicursor.nvim",
  event = "User File",
  branch = "1.0",
  config = function()
    local mc = require "multicursor-nvim"

    mc.setup()

    function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { desc = desc }) end

    map({ "n", "v" }, "<C-Up>", function() mc.addCursor "k" end, "Add a cursor above")
    map({ "n", "v" }, "<C-Down>", function() mc.addCursor "j" end, "Add a cursor below")
    map({ "n", "v" }, "<C-n>", function() mc.addCursor "*" end, "Add a cursor and jump to next word")
    map({ "n", "v" }, "<C-Left>", mc.nextCursor, "Switch to next cursor")
    map({ "n", "v" }, "<C-Right>", mc.prevCursor, "Switch to previous cursor")
    map({ "n", "v" }, "<leader>x", mc.deleteCursor, "Delete main cursor")
    map("n", "<C-LeftMouse>", mc.handleMouse, "Add a cursor with mouse")

    map({ "n", "v" }, "<C-L>", function()
      if mc.cursorsEnabled() then
        mc.disableCursors()
      else
        mc.addCursor()
      end
    end, "Lock other cursors")

    map("n", "<Esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        -- default <esc> handler.
      end
    end)

    map("n", "<Leader>mA", mc.alignCursors, "Align cursors")
    map("v", "<Leader>ms", mc.splitCursors, "Split by regex")
    map("v", "<Leader>mi", mc.insertVisual, "Insert for each line of selections")
    map("v", "<Leader>ma", mc.appendVisual, "Append for each line of selections")
    map("v", "<Leader>mm", mc.matchCursors, "Match new cursors by regex")
    map("v", "<Leader>mt", function() mc.transposeCursors(1) end, "Rotate content right")
    map("v", "<Leader>mT", function() mc.transposeCursors(-1) end, "Rotate content left")

    -- customize how cursors look
    vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
    vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
  end,
}
