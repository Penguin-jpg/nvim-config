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
  callback = function(args)
    -- add cache for buffers that have already had mappings created
    if not vim.g.q_close_windows then vim.g.q_close_windows = {} end
    -- if the buffer has been checked already, skip
    if vim.g.q_close_windows[args.buf] then return end
    -- mark the buffer as checked
    vim.g.q_close_windows[args.buf] = true
    -- if the buftype is a non-real file, create one
    if
      vim.tbl_contains(
        { "help", "nofile", "quickfix", "checkhealth", "lspinfo", "gitsigns.blame", "grug-far" },
        vim.bo[args.buf].buftype
      )
    then
      vim.keymap.set("n", "q", "<Cmd>close<CR>", {
        desc = "Close window",
        buffer = args.buf,
        silent = true,
        nowait = true,
      })
    end
  end,
})
create_autocmd("BufDelete", {
  desc = "Clean up q_close_window cache",
  group = "q_close_window",
  callback = function(args)
    if vim.g.q_close_windows then vim.g.q_close_windows[args.buf] = nil end
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

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
create_autocmd("LspProgress", {
  desc = "Show LSP progress",
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then return end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v) return table.insert(msg, v.msg) or not v.done end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

create_autocmd("BufEnter", {
  desc = "Automatically detect project root",
  callback = function()
    local root = vim.fs.root(0, { ".git", "package.json", "Makefile", "pyproject.toml" }) or "."
    vim.cmd.cd(root)
  end,
})
