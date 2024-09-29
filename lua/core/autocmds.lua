local create_augroup = function(name) vim.api.nvim_create_augroup(name, { clear = true }) end
local create_autocmd = vim.api.nvim_create_autocmd
local utils = require "utils.autocmds"

create_augroup "custom_user_events"
create_augroup "on_buffer_enter"
create_augroup "on_filetypes"
create_augroup "on_buffer_delete"
create_augroup "to_last_position"
create_augroup "q_close_windows"
create_augroup "clear_last_search"
create_augroup "highlight_yank"
create_augroup "highlight_search"
create_augroup "remove_trailing_whitespace"

-- modified from https://github.com/NormalNvim/NormalNvim/blob/main/lua/base/3-autocmds.lua
create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
  desc = "Nvim user events for file detection (File and GitFile)",
  group = "custom_user_events",
  callback = function(args)
    local empty_buffer = vim.fn.resolve(vim.fn.expand "%") == ""
    local greeter = vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "dashboard"
    local git_repo =
      utils.run_cmd({ "git", "-C", vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand "%"), ":p:h"), "rev-parse" }, false)

    -- for any file exept empty buffer, or the greeter (dashboard)
    if not (empty_buffer or greeter) then
      utils.trigger_event "User File"

      -- is the buffer part of a git repo?
      if git_repo then utils.trigger_event "User GitFile" end
    end
  end,
})

create_autocmd("BufEnter", {
  desc = "Disable auto insert comment newline",
  group = "on_buffer_enter",
  command = "set formatoptions-=cro",
})

create_autocmd("BufEnter", {
  desc = "Remap <C-z> to nothing so that it doesn't suspend terminal",
  group = "on_buffer_enter",
  command = "nnoremap <c-z> <nop>",
})

create_autocmd("FileType", {
  desc = "Enable wrap and spell for text like documents",
  group = "on_filetypes",
  pattern = { "gitcommit", "markdown", "text", "plaintext" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

create_autocmd("FileType", {
  desc = "Disable view saving for Oil buffers",
  group = "on_filetypes",
  pattern = "oil",
  callback = function(args) vim.b[args.buf].view_activated = false end,
})

create_autocmd("BufWinEnter", {
  desc = "Jump to last position when reopening a file",
  group = "to_last_position",
  pattern = "*",
  command = [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
})

create_autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = "q_close_windows",
  callback = function(event)
    if
      vim.tbl_contains(
        { "help", "nofile", "quickfix", "checkhealth", "lspinfo", "gitsigns.blame" },
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

create_autocmd("BufWinEnter", {
  desc = "Clear last search pattern",
  group = "clear_last_search",
  pattern = "*",
  command = "let @/ = ''",
})

create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = "highlight_yank",
  callback = function() vim.highlight.on_yank() end,
})

create_autocmd("BufWritePre", {
  desc = "Remove trailing whitespaces on save",
  group = "remove_trailing_whitespace",
  pattern = "*",
  callback = function()
    -- save cursor position to later restore
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    -- Search and replace trailing whitespace
    vim.cmd [[keeppatterns %s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end,
})
