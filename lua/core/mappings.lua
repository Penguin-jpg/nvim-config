local set_map = vim.keymap.set

-- utilities
set_map({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Esc>", { desc = "Escape and Clear hlsearch" })

-- move
set_map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
set_map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
set_map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
set_map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- write/close
set_map("n", "<C-s>", "<Cmd>w<CR>", { desc = "Save" })
set_map("n", "<C-q>", "<Cmd>confirm q<CR>", { desc = "Quit" })
set_map("i", "<C-s>", "<Cmd>w<CR>", { desc = "Save" })
set_map("n", "<Leader>bc", "<Cmd>bdelete<CR>", { desc = "Close buffer" })

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
set_map("v", ">", ">gv", { desc = "Indent line" })
set_map("v", "<", "<gv", { desc = "Unindent line" })

-- separate cut and delete motion
set_map({ "n", "v" }, "d", '"_d', { desc = "Delete" })
set_map({ "n", "v" }, "c", '"_c', { desc = "Delete and start insert" })
set_map({ "n", "v" }, "X", "d", { desc = "Cut" })

-- navigation
set_map("n", "[b", "<Cmd>bprev<CR>", { desc = "Previous buffer" })
set_map("n", "]b", "<Cmd>bnext<CR>", { desc = "Next buffer" })
set_map("n", "[t", function() vim.cmd.tabprevious() end, { desc = "Previous tab" })
set_map("n", "]t", function() vim.cmd.tabnext() end, { desc = "Next tab" })

-- jump/select
set_map("n", "ga", "ggVG", { desc = "Select all lines" })
set_map({ "n", "v" }, "H", "_", { desc = "Jump to beginning of line" })
set_map({ "n", "v" }, "L", "$", { desc = "Jump to end of line" })
set_map({ "n", "v" }, "K", "5k", { desc = "Move up 5 lines" })
set_map({ "n", "v" }, "J", "5j", { desc = "Move down 5 lines" })
-- set_map("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after jumping up" })
-- set_map("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after jumping down" })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set_map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
set_map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
set_map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Previous Search Result" })
set_map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Previous Search Result" })

-- split
set_map("n", "|", "<Cmd>vsplit<CR>", { desc = "Vertical split", remap = true })
set_map("n", "\\", "<Cmd>split<CR>", { desc = "Horizontal split", remap = true })
set_map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
set_map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
set_map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
set_map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
set_map("n", "<A-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Resize split left" })
set_map("n", "<A-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Resize split right" })
set_map("n", "<A-Up>", "<Cmd>resize -2<CR>", { desc = "Resize split up" })
set_map("n", "<A-Down>", "<Cmd>resize +2<CR>", { desc = "Resize split down" })

-- buffer
set_map("n", "<Leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- quickfix and location list
set_map("n", "<Leader>xl", "<Cmd>lopen<CR>", { desc = "Location list" })
set_map("n", "<Leader>xq", "<Cmd>copen<CR>", { desc = "Quickfix list" })

-- comments
set_map("n", "<C-_>", "gcl", { desc = "Toggle comment line", remap = true })
set_map("i", "<C-_>", "<C-o>gcl", { desc = "Toggle comment line", remap = true })
set_map("x", "<C-_>", "gc", { desc = "Toggle comment", remap = true })
set_map("n", "gco", "o<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<BS>", { desc = "Add comment below" })
set_map("n", "gcO", "O<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<BS>", { desc = "Add comment above" })

-- diagnostics
local function diagnostic_jump(dir, severity)
  local jump_opts = {}
  if type(severity) == "string" then jump_opts.severity = vim.diagnostic.severity[severity] end
  return function()
    jump_opts.count = dir and vim.v.count1 or -vim.v.count1
    vim.diagnostic.jump(jump_opts)
  end
end
set_map("n", "[e", diagnostic_jump(false, "ERROR"), { desc = "Previous error" })
set_map("n", "]e", diagnostic_jump(true, "ERROR"), { desc = "Next error" })
set_map("n", "[w", diagnostic_jump(false, "WARN"), { desc = "Previous warning" })
set_map("n", "]w", diagnostic_jump(true, "WARN"), { desc = "Next warning" })
set_map(
  "n",
  "gl",
  function() vim.diagnostic.config { virtual_text = false, virtual_lines = { current_line = true } } end,
  { desc = "Show virtual lines" }
)
set_map("n", "gL", function() vim.diagnostic.open_float() end, { desc = "Hover diagnostics" })
