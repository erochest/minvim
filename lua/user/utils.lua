
local M = {}

---Generate a Github URL
---@param path The user/repo for the package.
---@return The full Github URL for the package.
function M.gh(path)
	return "https://github.com/" .. path
end

local packages_ensure_installed = {}

--- Add a list of packages to the global list to ensure are installed.
---@param packages a list of Mason package names
function M.ensure_installed(packages)
  for _, package in ipairs(packages) do
    packages_ensure_installed[package] = true
  end
end

--- Return the packages that have been accumulated to make sure are installed.
---@return array/list of package names
function M.get_ensure_installed()
  local packages = {}
  for key, value in pairs(packages_ensure_installed) do
    if value then
      table.insert(packages, key)
    end
  end
  return packages
end

return M

