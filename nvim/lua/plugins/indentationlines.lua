local M = {}

function M.setup()
    vim.opt.list = true
    vim.opt.listchars:append("space: ")
    -- vim.opt.listchars:append "eol:↴"

    local highlight = {
        "RainbowBlue",
        "RainbowCyan",
        "RainbowGreen",
        "RainbowYellow",
        "RainbowOrange",
        "RainbowRed",
        "RainbowRed",
        "RainbowRed",
        "RainbowRed",
        "RainbowRed",
        "RainbowRed",
        "RainbowRed",
        "RainbowRed",
        "RainbowRed",
    }

    local selectHL = "SelectedHighLight"

    local hooks = require("ibl.hooks")

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#22dd44" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#22dddd" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#2244dd" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#8822dd" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#dddd22" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#dd8822" })
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#dd2222" })
        vim.api.nvim_set_hl(0, "SelectedHighLight", { fg = "#222222" })
    end)

    local status, ibl = pcall(require, "ibl")
    if not status then
        return
    end

    ibl.setup({
        scope = {
            highlight = selectHL,
        },
        indent = {
            char = "|",
            tab_char = {
                "▎","▎","▍","▍","▌","▌",
                "▋","▋","▊","▊","▉","▉",
                "█","█",
            },
            highlight = highlight,
        },
    })
end

return M
