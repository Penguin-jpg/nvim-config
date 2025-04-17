-- code from https://github.com/NormalNvim/NormalNvim/blob/main/lua/base/utils/init.lua

local M = {}

--- Run a shell command and capture the output and if the command
--- succeeded or failed.
---@param cmd string|string[] The terminal command to execute
---@param show_error? boolean If true, print errors if the command fail.
---@return string|nil # The result of a successfully executed command or nil
function M.run_cmd(cmd, show_error)
  if type(cmd) == "string" then cmd = vim.split(cmd, " ") end
  if vim.fn.has "win32" == 1 then cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd) end
  local result = vim.fn.system(cmd)
  local success = vim.api.nvim_get_vvar "shell_error" == 0
  if not success and (show_error == nil or show_error) then
    vim.api.nvim_echo({
      {
        ("Error running command %s\nError message:\n%s"):format(
          table.concat(cmd, " "), -- convert the cmd back to string.
          result -- show the error result
        ),
      },
    }, true, { err = true })
  end
  return (success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "")) or nil
end

--- Convenient wapper to save code when we Trigger events.
--- To listen for an event triggered by this function you can use `autocmd`.
---@param event string Name of the event.
---@param is_urgent boolean|nil If true, trigger directly instead of scheduling. Useful for startup events.
-- @usage To run a User event:   `trigger_event("User MyUserEvent")`
-- @usage To run a Neovim event: `trigger_event("BufEnter")
function M.trigger_event(event, is_urgent)
  -- define behavior
  local function trigger()
    local is_user_event = string.match(event, "^User ") ~= nil
    if is_user_event then
      event = event:gsub("^User ", "")
      vim.api.nvim_exec_autocmds("User", { pattern = event, modeline = false })
    else
      vim.api.nvim_exec_autocmds(event, { modeline = false })
    end
  end

  -- execute
  if is_urgent then
    trigger()
  else
    vim.schedule(trigger)
  end
end

return M
