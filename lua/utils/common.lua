local M = {}

function M.bool2str(bool)
  return bool and "on" or "off"
end

function M.notify(msg, type, opts)
  vim.schedule(function()
    vim.notify(msg, type, vim.tbl_deep_extend("force", {title = "Neovim"}, opts or {}))
  end)
end

function M.which_key_register(mappings, opts)
  local wk_avail, wk = pcall(require, "which-key")
  if wk_avail then
    wk.add(mappings, opts)
  end
end

return M
