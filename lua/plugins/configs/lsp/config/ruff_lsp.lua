return {
  on_attach = function(client, bufnr)
    -- Disable ruff_lsp hover in favor of pyright
    if client.name == "ruff_lsp" then client.server_capabilities.hoverProvider = false end
    -- Create an autocmd to organize import on save
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   buffer = bufnr,
    --   callback = function()
    --     vim.lsp.buf.code_action {
    --       context = { only = { "source.fixAll.ruff" } },
    --       apply = true,
    --     }
    --   end,
    -- })
  end,
}
