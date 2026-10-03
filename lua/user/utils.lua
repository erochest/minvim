
local M = {}

---Generate a Github URL
---@param path The user/repo for the package.
---@return The full Github URL for the package.
function M.gh(path)
	return "https://github.com/" .. path
end

return M

