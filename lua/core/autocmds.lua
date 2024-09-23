local create_augroup = function(name) vim.api.nvim_create_augroup(name, { clear = true }) end

create_augroup "on_buffer_enter"
create_augroup "on_filetypes"
create_augroup "custom_events"
create_augroup "on_buffer_delete"
create_augroup "to_last_position"
create_augroup "q_close_windows"
create_augroup "clear_last_search"
create_augroup "highlight_yank"
create_augroup "highlight_search"
create_augroup "remove_trailing_whitespace"
create_augroup "dashboard_when_no_buffer"

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

vim.api.nvim_create_autocmd("FileType", {
  desc = "Disable view saving for Oil buffers",
  group = "on_filetypes",
  pattern = "oil",
  callback = function(args) vim.b[args.buf].view_activated = false end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  desc = "Custom BufDeletePost user event",
  group = "custom_events",
  callback = function()
    vim.schedule(
      function()
        vim.api.nvim_exec_autocmds("User", {
          pattern = "BufDeletePost",
        })
      end
    )
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Jump to last position when reopening a file",
  group = "to_last_position",
  pattern = "*",
  command = [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = "q_close_windows",
  callback = function(event)
    if
      vim.tbl_contains(
        { "help", "nofile", "quickfix", "checkhealth", "lspinfo", "grug-far", "gitsigns.blame" },
        vim.bo[event.buf].buftype
      )
    then
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

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove trailing whitespaces on save",
  group = "remove_trailing_whitespace",
  pattern = "*",
  callback = function()
    -- save cursor position to later restore
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    -- Search and replace trailing whitespace
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end,
})

vim.api.nvim_create_autocmd("User", {
  desc = "Open dashboard when no available buffers",
  group = "dashboard_when_no_buffer",
  pattern = "BufDeletePost",
  callback = function(event)
    local deleted_name = vim.api.nvim_buf_get_name(event.buf)
    local deleted_ft = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
    local deleted_bt = vim.api.nvim_get_option_value("buftype", { buf = event.buf })
    local dashboard_on_empty = deleted_name == "" and deleted_ft == "" and deleted_bt == ""
    if dashboard_on_empty then vim.cmd "Dashboard" end
  end,
})
