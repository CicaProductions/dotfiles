local M = {}

local severity_map={
	[vim.diagnostic.severity.ERROR] = "LineNrError",
  [vim.diagnostic.severity.WARN]  = "LineNrWarn",
  [vim.diagnostic.severity.INFO]  = "LineNrInfo",
  [vim.diagnostic.severity.HINT]  = "LineNrHint",
}

-- Setup highlights
local function setup_highlights()
  vim.api.nvim_set_hl(0, "LineNrError", { link="DiagnosticError",
		bg="#ff6767",
		fg="#a277ff"})
  vim.api.nvim_set_hl(0, "LineNrWarn",  { link = "DiagnosticWarn",
		bg="#c55858",
		fg="#a277ff"})
  vim.api.nvim_set_hl(0, "LineNrInfo",  { link = "DiagnosticInfo",
		bg="#6cb2c7",
		fg="#a277ff"})
  vim.api.nvim_set_hl(0, "LineNrHint",  { link = "DiagnosticHint",
		bg="#15141b",
		fg="#a277ff"})
end

local function get_severity(lnum)
	local diags = vim.diagnostic.get(0,{lnum=lnum-1})
	if not diags or #diags == 0  then
		return nil
	end
	local min = diags[1].severity
	for _, d in ipairs(diags) do
		if d.severity<min then
			min = d.severity
		end
	end

	return min
end

function _G.LineDiagnosticsStatusColumn()
	vim.diagnostic.config({
		signs = false,
	})
  local lnum = vim.v.lnum
  local relnum = vim.v.relnum

	if vim.wo.relativenumber and relnum~=0 then
		number=relnum
	else
		number=lnum
	end
  local width = vim.o.numberwidth
  local num = string.format("%" .. width .. "d", number)

  local severity = get_severity(lnum)
  if severity then
    local hl = severity_map[severity]
    return "%#" .. hl .. "#" .. num .. " %*"
  end

  return "%#LineNr#" .. num .. " %*"
end

function M.setup(opts)
  opts = opts or {}

  setup_highlights()

  vim.o.statuscolumn = "%!v:lua.LineDiagnosticsStatusColumn()"
  vim.wo.number = false
  vim.wo.relativenumber = true
end

return M
