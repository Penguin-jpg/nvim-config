local create_augroup = function(name) vim.api.nvim_create_augroup(name, { clear = true }) end

create_augroup "on_buffer_enter"
create_augroup "on_filetypes"
create_augroup "q_close_windows"
create_augroup "clear_last_search"
create_augroup "highlight_yank"
create_augroup "highlight_search"

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Disable auto insert comment newline",
  group = "on_buffer_enter",
  command = "set formatoptions-=cro",
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Remap <C-z> to nothing so that it doesn't suspend terminal",
  group = "on_buffer_enter",
  command = "nnoremap <c-z> <nop>",
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable wrap and spell for text like documents",
  group = "on_filetypes",
  pattern = { "gitcommit", "markdown", "text", "plaintext" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = "q_close_windows",
  callback = function(event)
    if vim.tbl_contains({ "help", "nofile", "quickfix" }, vim.bo[event.buf].buftype) then
      vim.keymap.set("n", "q", "<Cmd>close<CR>", {
        desc = "Close window",
        buffer = event.buf,
        silent = true,
        nowait = true,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Clear last search pattern",
  group = "clear_last_search",
  pattern = "*",
  command = "let @/ = ''",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = "highlight_yank",
  callback = function() vim.highlight.on_yank() end,
})
