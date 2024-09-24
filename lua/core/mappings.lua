local set_map = vim.keymap.set

-- move
for _, mode in pairs { "n", "x" } do
  set_map(mode, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
  set_map(mode, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
  set_map(mode, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
  set_map(mode, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
end

-- write/close
set_map("n", "<C-s>", "<Cmd>w<CR>", { desc = "Save file" })
set_map("n", "<C-q>", "<Cmd>confirm q<CR>", { desc = "Quit file" })
set_map("i", "<C-s>", "<Cmd>w<CR>", { desc = "Save file" })
set_map("n", "<Leader>c", "<Cmd>bdelete<CR>", { desc = "Close buffer" })

-- yank/paste
-- for _, mode in pairs { "n", "v" } do
--   set_map(mode, "y", "mmy`m", { desc = "Yank without moving back cursor" })
-- end

-- common motions
set_map("n", "<C-z>", "u", { desc = "Undo" })
set_map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
set_map("i", "<C-Del>", "<C-o>dw", { desc = "Delete a word backward" })
set_map("i", "<S-Tab>", "<C-d>", { desc = "Unindent line" })
set_map("v", "<Tab>", ">gv", { desc = "Indent line" })
set_map("v", "<S-Tab>", "<gv", { desc = "Unindent line" })

-- separate cut and delete motion
for _, mode in pairs { "n", "v" } do
  set_map(mode, "d", '"_d', { desc = "Delete" })
  set_map(mode, "X", "d", { desc = "Cut" })
end

-- jump/select
set_map("n", "ga", "ggVG", { desc = "Select all lines" })
for _, mode in pairs { "n", "v" } do
  set_map(mode, "H", "^", { desc = "Jump to beginning of line" })
  set_map(mode, "L", "$", { desc = "Jump to end of line" })
  set_map(mode, "K", "5k", { desc = "Move up 5 lines" })
  set_map(mode, "J", "5j", { desc = "Move down 5 lines" })
end

-- split
set_map("n", "|", "<Cmd>vsplit<CR>", { desc = "Vertical split" })
set_map("n", "\\", "<Cmd>split<CR>", { desc = "Horizontal split" })
set_map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
set_map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
set_map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
set_map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
set_map("n", "<A-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Resize split left" })
set_map("n", "<A-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Resize split right" })
set_map("n", "<A-Up>", "<Cmd>resize -2<CR>", { desc = "Resize split up" })
set_map("n", "<A-Down>", "<Cmd>resize +2<CR>", { desc = "Resize split down" })
