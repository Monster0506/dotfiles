local M = {}

local wk = require("which-key")

function M.setup()
    require("keybinds")
    local opts = {noremap = true, silent = true}
    local keymap = vim.api.nvim_set_keymap

    -- Keybindings {{{
    -- Miscellaneous Mappings {{{
    keymap("n", "<leader>t", "<cmd>Vista nvim_lsp<CR>", opts)
    keymap("n", "+", "<C-a>", opts)
    keymap("n", "<C-t>", "<cmd>NvimTreeToggle<CR>", opts)
    keymap("n", "<F2>", "<cmd>setlocal spell! spelllang=en_us<CR>", opts)
    keymap("c", "cd.", "lcd %:p:h<CR>", opts)
    keymap("c", "cwd", "lcd %:p:h<CR>", opts)
    keymap("i", "<leader><C-i>", "<cmd>PickEverythingInsert<CR>", opts)
    keymap("x", "<", "<gv", opts)
    keymap("x", ">", ">gv", opts)
    wk.register(
        {
            M = {require("ufo").closeAllFolds, "Close All Folds"},
            R = {require("ufo").openAllFolds, "Open All Folds"}
        },
        {prefix = "z"}
    )

    wk.register(
        {
            l = {
                ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>",
                "Modify Registers"
            },
            ["<C-i>"] = {"<cmd>PickEverythingInsert<CR>", "Pick Everything"},
            t = {
                name = "Vista",
                a = {
                    name = "Vista",
                    g = {"<cmd>Vista ctags<CR>", "Ctags"},
                    m = {"<cmd>Vista nvim_lsp<CR>", "LSP Markers"}
                }
            },
            y = {'"+y', "Yank to Clipboard"}
        },
        {prefix = "<leader>"}
    )
    --- }}}
    --- }}}
end

return M
