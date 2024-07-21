return {
  capabilities = {
    offsetEncoding = "utf-8",
  },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--all-scopes-completion",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--fallback-style=Microsoft",
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = false,
    completeUnimported = true,
  },
}
