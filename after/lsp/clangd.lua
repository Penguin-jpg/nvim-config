return {
  capabilities = {
    offsetEncoding = "utf-8",
  },
  cmd = {
    "clangd",
    "--background-index",
    "-j=4",
    "--clang-tidy",
    "--all-scopes-completion",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders=0",
    "--fallback-style=LLVM",
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = false,
    completeUnimported = true,
  },
  on_attach = function(client) require "clangd_extensions" end,
}
