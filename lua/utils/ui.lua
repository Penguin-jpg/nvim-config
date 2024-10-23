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
M.conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand "%:t") ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand "%:p:h"
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}
-------------------------------------------------

--------------------icons------------------------
M.icons = {
  lsp = {
    ActiveLSP = "",
    ActiveTS = "",
  },
  git = {
    Github = "",
    Add = "",
    Branch = "",
    Change = "",
    Conflict = "",
    Delete = "",
    Ignored = "",
    Renamed = "",
    Staged = "✓",
    Unstaged = "✗",
    Untracked = "★",
  },
  files = {
    Ellipsis = "",
    Default = "",
    Modified = "",
    ReadOnly = "",
    FoldClosed = "",
    FoldOpened = "",
    FolderClosed = "",
    FolderEmpty = "",
    FolderOpen = "",
  },
  diagnostic = {
    Diagnostic = "󰒡",
    Error = "",
    Hint = "",
    Info = "󰋼",
    Warn = "",
  },
  dap = {
    Breakpoint = "",
    BreakpointCondition = "",
    BreakpointRejected = "",
    LogPoint = "",
    Stopped = "",
  },
  kind = {
    Array = "",
    Boolean = "",
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "",
    File = "",
    Folder = "",
    Function = "",
    Interface = "",
    Key = "",
    Keyword = "󰌋",
    Method = "",
    Module = "",
    Namespace = "",
    Null = "",
    Number = "",
    Object = "",
    Operator = "",
    Package = "",
    Property = "",
    Reference = "",
    Snippet = "󰗀",
    String = "",
    Struct = "",
    Text = "󰉿",
    TypeParameter = "",
    Unit = "ﱦ",
    Value = "",
    Variable = "",
  },
  plugins = {
    Neogit = "",
    Grapple = "󰓹",
    Codeium = "󱚝",
    Yazi = "󰇥",
    Oil = "",
  },
  misc = {
    Mode = "󰊠",
    FileEncoding = "",
    ScrollText = "",
    TabWidth = "",
    Search = "",
    WordSearch = "󱎸",
    Evil = "",
    Selected = "❯",
    Save = "󰆓",
    Recording = "",
  },
}

function M.get_icon(type, name)
  if M.icons[type] == nil and M.icons[type][name] == nil then return " " end
  if name == nil then return M.icons[type] end
  return M.icons[type][name]
end
------------------------------------------------

------------------general-----------------------
function M.get_highlight(group_name) return vim.api.nvim_get_hl(0, { name = group_name }) end
------------------------------------------------

return M
