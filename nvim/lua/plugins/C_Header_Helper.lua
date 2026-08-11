-- ~/.config/nvim/config/sfml.lua
-- Auto-generate compile_flags.txt for SFML-based projects using pkg-config

local M = {}

function M.generate_compile_flags()
  local handle = io.popen("pkg-config --cflags sfml-all 2>/dev/null")
  if not handle then
    vim.notify("pkg-config not found or SFML not installed", vim.log.levels.WARN)
    return
  end

  local output = handle:read("*a")
  handle:close()

  if not output or output == "" then
    vim.notify("pkg-config returned no SFML flags", vim.log.levels.WARN)
    return
  end

  local flags = {}
  for flag in string.gmatch(output, "%S+") do
    table.insert(flags, flag)
  end

  local file = io.open("compile_flags.txt", "w")
  if file then
    for _, flag in ipairs(flags) do
      file:write(flag .. "\n")
    end
    file:close()
    vim.notify("Generated compile_flags.txt from pkg-config (SFML)", vim.log.levels.INFO)
  end
end

function M.setup_autogen()
  vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = "*.cpp",
    callback = function()
      M.generate_compile_flags()
    end,
  })
end

return M
