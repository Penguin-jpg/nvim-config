local M = {}

-- insert contents of t2 into t1
function M.extend_table(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end

  return t1
end

return M
