local M = {}

local chars={"(","[","{"}
local cchars={")","]","}"}
local function check_char(b,a)
	local bc=false
	local ac=false
	for _,char in ipairs(chars) do
		if char==b then
			bc=true
		end
	end
	if not bc then
		return false
	end
	for _,char in ipairs(cchars) do
		if char==a then
			ac=true
		end
	end
	return ac
end

function M.smart_block()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	
	local before = line:sub(col,col)
	local after = line:sub(col+1,col+1)

	if check_char(before, after) then
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<CR><Esc>O", true, false, true),
      "n",
      true
    )
    return ""
	end
	return "\n"
end

return M
