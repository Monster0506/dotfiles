local function folds()
    local lnum = tostring(vim.v.lnum)
    if vim.v.virtnum > 0 or vim.v.virtnum < 0 then
        return ""
    end
    local icon
    if vim.fn.foldlevel(vim.v.lnum) <= 0 or vim.fn.foldlevel(vim.v.lnum) <= vim.fn.foldlevel(vim.v.lnum - 1) then
        icon = "  "
    elseif vim.fn.foldclosed(vim.v.lnum) == -1 then
        icon = ""
    else
        icon = ""
    end
    return icon
end

local config = {
    setopt = true,
    foldfunc = folds,
    separator = " "
}
local sc = require("statuscol")
sc.setup(config)
