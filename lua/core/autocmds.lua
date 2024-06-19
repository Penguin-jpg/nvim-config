-- Some commands that I want to execute in specific timing
vim.api.nvim_create_augroup("disable_comment_newline", { clear = true })
vim.api.nvim_create_augroup("auto_wrap", { clear = true })
vim.api.nvim_create_augroup("disable_suspend_with_c_z", { clear = true })
vim.api.nvim_create_augroup("clear_last_search", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Disable auto insert comment newline",
  group = "disable_comment_newline",
  command = "set formatoptions-=cro",
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable wrap and spell for text like documents",
  group = "auto_wrap",
  pattern = { "gitcommit", "markdown", "text", "plaintext" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Remap <C-z> to nothing so that it doesn't suspend terminal",
  group = "disable_suspend_with_c_z",
  command = "nnoremap <c-z> <nop>",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Clear last search pattern",
  group = "clear_last_search",
  pattern = "*",
  command = "let @/ = ''",
})
