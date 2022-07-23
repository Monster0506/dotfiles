local M = {}

function M.setup()
    -- Options (vim.opt) {{{
    local vimopts = {
        background = "dark",
        termguicolors = true,
        relativenumber = true,
        number = true,
        undofile = true,
        smartcase = true,
        mouse = "a",
        guifont = "FiraCode Nerd Font:h15",
        ignorecase = true,
        expandtab = true,
        backup = false,
        swapfile = false,
        wildignore = "*.docx,*.pdf,*.exe,*.mcmeta,*.xlsx",
        colorcolumn = "80",
        foldmethod = "syntax",
        concealcursor = "nc",
        list = true
    }
    for k, v in pairs(vimopts) do
        vim.opt[k] = v
    end
    vim.opt.listchars:append("eol:↴")
    --- }}}
end

return M
