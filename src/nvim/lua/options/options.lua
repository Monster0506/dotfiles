-- Options (vim.opt) {{{
local vimopts = {
    -- {{{
    background = "dark",
    termguicolors = true,
    foldcolumn = "0",
    foldlevel = 99,
    splitright = true,
    splitbelow = true,
    foldlevelstart = 99,
    foldenable = true,
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
    list = true,
    listchars = {
        ["tab"] = "» ",
        ["trail"] = "·",
        ["extends"] = "<",
        ["precedes"] = ">",
        ["conceal"] = "┊",
        ["nbsp"] = "␣",
        ["eol"] = "↴"
    }
    -- }}}
}
for k, v in pairs(vimopts) do -- {{{
    vim.opt[k] = v
    -- }}}
end
--- }}}}}}
