local M = {}

local icons = {
  git = {
    hub = "",
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
  },
  misc = {
    Mode = "󰊠",
    FileEncoding = "",
    ScrollText = "",
    TabWidth = "",
    Search = "",
    WordSearch = "󱎸",
  },
}

function M.get_icon(type, name)
  if icons[type] == nil and icons[type][name] == nil then return " " end
  if name == nil then return icons[type] end
  return icons[type][name]
end

return M