local M = {}

M.opts = {
  ensure_installed = {
    'clangd',
    'clang-format',
    'lua-language-server',
    'stylua',
    'typescript-language-server',
    'vue-language-server',
  },
}

M.ensure_installed = function(packages)
  if packages == nil then
    return
  end

  local mr = require('mason-registry')

  mr.refresh(function()
    local install_needed = {}

    for _, tool in ipairs(packages) do
      local p = mr.get_package(tool)

      if not p:is_installed() then
        table.insert(install_needed, tool)
      end
    end

    if not next(install_needed) then
      return
    end

    vim.cmd('Mason')

    for _, tool in ipairs(install_needed) do
      mr.get_package(tool):install()
    end
  end)
end

return M
