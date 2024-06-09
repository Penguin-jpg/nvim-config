-- Some commands that I want to execute in specific timing
vim.api.nvim_create_augroup("disable_comment_header", { clear = true })
vim.api.nvim_create_augroup("auto_wrap", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Disable auto insert comment header",
  group = "disable_comment_header",
  command = "set formatoptions-=cro",
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable wrap and spell for text like documents",
  pattern = { "gitcommit", "markdown", "text", "plaintext" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
