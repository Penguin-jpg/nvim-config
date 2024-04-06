return function(opts)
  opts.components = {
    "mode",
    "git-branch"
    "git-diff",
    "%=", -- add empty space
    "os-uname",
    "lsps-formatters",
    "indent",
    "encoding",
    "pos-cursor",
    "pos-cursor-progress",
  }
  
  return opts
end