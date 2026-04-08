local create_augroup = function(name) vim.api.nvim_create_augroup(name, { clear = true }) end
local create_autocmd = vim.api.nvim_create_autocmd
local utils = require "utils.autocmds"

create_augroup "custom_user_events"
create_augroup "on_buffer_enter"
create_augroup "on_filetypes"
create_augroup "on_buffer_delete"
create_augroup "to_last_position"
create_augroup "q_close_window"
create_augroup "clear_last_search"
create_augroup "highlight_yank"
create_augroup "auto_parent_dir"
create_augroup "checktime"
create_augroup "remove_trailing_whitespace"

-- modified from https://github.com/NormalNvim/NormalNvim/blob/main/lua/base/3-autocmds.lua
create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
  desc = "Nvim user events for file detection (File and GitFile)",
  group = "custom_user_events",
  callback = function(args)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(args.buf) then return end
      local empty_buffer = vim.fn.resolve(vim.fn.expand "%") == ""
      local greeter = vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "dashboard"
      local git_repo = utils.run_cmd(
        { "git", "-C", vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand "%"), ":p:h"), "rev-parse" },
        false
      )
      -- for any file exept empty buffer, or the greeter (dashboard)
      if not (empty_buffer or greeter) then
        local skip_augroups = {}
        for _, autocmd in ipairs(vim.api.nvim_get_autocmds { event = args.event }) do
          if autocmd.group_name then skip_augroups[autocmd.group_name] = true end
        end
        skip_augroups["filetypedetect"] = false -- don't skip filetypedetect events

        -- utils.trigger_event("User File", true)
        utils.trigger_event "User File"

        -- is the buffer part of a git repo?
        if git_repo then utils.trigger_event "User GitFile" end

        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].buflisted then
            for _, autocmd in ipairs(vim.api.nvim_get_autocmds { event = args.event }) do
              if autocmd.group_name and not skip_augroups[autocmd.group_name] then
                vim.api.nvim_exec_autocmds(
                  args.event,
                  { group = autocmd.group_name, buffer = args.buf, data = args.data }
                )
                skip_augroups[autocmd.group_name] = true
              end
            end
          end
        end)
      end
    end)
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

-- prefer LSP folding if client supports it
create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil and client:supports_method "textDocument/foldingRange" then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})

-- recover the default foldexpr
create_autocmd("LspDetach", { command = "setl foldexpr<" })

create_autocmd("BufReadPost", {
  desc = "Jump to last position when opening a file",
  group = "to_last_position",
  callback = function(args)
    local buf = args.buf
    if vim.b[buf].last_loc_restored or vim.tbl_contains({ "gitcommit" }, vim.bo[buf].filetype) then return end
    vim.b[buf].last_loc_restored = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(buf) then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

create_autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = "q_close_window",
  pattern = { "help", "nofile", "quickfix", "checkhealth", "lspinfo", "gitsigns.blame" },
  callback = function(event)
    vim.keymap.set("n", "q", "<Cmd>Close<CR>", {
      buffer = event.buf,
      silent = true,
      nowait = true,
      desc = "Close window",
    })
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
  desc = "Automatically create parent directories if they don't exist when saving a file",
  group = "auto_parent_dir",
  callback = function(event)
    if event.match:match "^%w%w+:[\\/][\\/]" then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if buffers changed on editor focus",
  group = "checktime",
  callback = function()
    if vim.bo.buftype ~= "nofile" then vim.cmd "checktime" end
  end,
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
