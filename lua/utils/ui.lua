local M = {}

-----------------dashboard----------------------
M.headers = {
  UWU = [[
    ⡆⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕
    ⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕
    ⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕
    ⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕
    ⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑
    ⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐
    ⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐
    ⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔
    ⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕
    ⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕
    ⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕
    ⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕
    ⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁
    ⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿
  ]],
  OH = [[
    ⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷
    ⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇
    ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽
    ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕
    ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕
    ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕
    ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄
    ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕
    ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿
    ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟
    ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠
    ⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙
    ⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣
  ]],
  BLINK = [[
    ⣿⠘⣿⣿⡇⣿⣿⣿⠿⠿⠿⣿⣿⣿⣿⣬⡀⣿⣤⡄⠄⠻⣦⡈⢿⣿⣿⣷⡌⢿
    ⡟⡇⠻⣿⡇⣿⢉⣥⠄⠄⢀⣀⠙⣟⠻⣿⣿⣿⣿⣿⣷⣤⠍⠓⢄⠛⢻⠿⣷⡈
    ⠃⡇⢀⢻⡇⢹⣼⡏⠄⠄⠄⠘⢰⣌⣷⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣄⡀⠈⠛⢿
    ⠄⣿⡜⣧⠙⠘⣿⡇⠄⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠄⠄
    ⠄⢸⣧⢸⠄⣿⣿⣷⣀⣉⣀⣼⣿⣿⣿⣿⣿⣿⣿⣿⠥⠒⣉⣉⠛⢿⡟⠋⠄⢸
    ⠄⠘⣿⡏⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾⣿⣿⣷⡾⠃⠄⡄⢠
    ⠄⠄⣿⣧⠄⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣵⣯⣫⣿⠟⠁⢠⣼⣧⣼
    ⠄⠄⢻⣿⠄⠄⠉⠛⢿⣿⣿⣯⡻⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⡄⢸⠿⣿⣿
    ⠄⠄⢸⣿⠄⠄⣤⠄⠄⠉⠛⠻⢿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠛⢃⠜⠄⣼⣀⣿⣿
  ]],
}

function M.get_header(name, num_head_lines, num_footer_lines)
  local header = M.headers["UWU"]
  if M.headers[name] ~= nil then header = M.headers[name] end
  return string.rep("\n", num_head_lines or 5) .. header .. string.rep("\n", num_footer_lines or 2)
end
------------------------------------------------

--------------------lualine---------------------
M.lualine = {
  conditions = {
    buffer_not_empty = function() return vim.fn.empty(vim.fn.expand "%:t") ~= 1 end,
    hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
    check_git_workspace = function()
      local filepath = vim.fn.expand "%:p:h"
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  },
}
-------------------------------------------------

--------------------icons------------------------
M.icons = {
  ActiveLSP = "",
  ActiveTS = "",
  Github = "",
  GitAdd = "",
  GitBranch = "",
  GitChange = "",
  GitConflict = "",
  GitDelete = "",
  GitIgnored = "",
  GitRenamed = "",
  GitStaged = "✓",
  GitUnstaged = "✗",
  GitUntracked = "★",
  Ellipsis = "",
  FileDefault = "",
  FileModified = "",
  FileReadOnly = "",
  FoldClosed = "",
  FoldOpened = "",
  FolderClosed = "",
  FolderEmpty = "",
  FolderOpen = "",
  Diagnostic = "󰒡",
  DiagnosticError = "",
  DiagnosticHint = "",
  DiagnosticInfo = "󰋼",
  DiagnosticWarn = "",
  DapBreakpoint = "",
  DapBreakpointCondition = "",
  DapBreakpointRejected = "",
  DapLogPoint = "",
  DapStopped = "",
  kind = {
    Array = "",
    Boolean = "󰨙",
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "",
    File = "",
    Folder = "",
    Function = "󰊕",
    Interface = "",
    Key = "󰌆",
    Keyword = "󰌋",
    Method = "",
    Module = "",
    Namespace = "",
    Null = "",
    Number = "",
    Object = "",
    Operator = "",
    Package = "",
    Property = "",
    Reference = "",
    Snippet = "󰗀",
    String = "",
    Struct = "",
    Text = "󰉿",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "󰀫",
  },
}

function M.get_icon(name, num_spaces)
  local result = M.icons[name] ~= nil and M.icons[name] or ""
  return result .. string.rep(" ", num_spaces or 0)
end

function M.get_kind_icons() return M.icons["kind"] end
------------------------------------------------

------------------general-----------------------
function M.get_colorscheme_name() return vim.api.nvim_get_var "colors_name" end

function M.get_highlight(group_name) return vim.api.nvim_get_hl(0, { name = group_name }) end
------------------------------------------------

return M
