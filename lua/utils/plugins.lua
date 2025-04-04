local M = {}

function M.get_plugin(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.spec.plugins[plugin] or nil
end

function M.is_available(plugin) return M.get_plugin(plugin) ~= nil end

function M.get_opts(plugin)
  local spec = M.get_plugin(plugin)
  return spec and require("lazy.core.plugin").values(spec, "opts") or {}
end

return M
