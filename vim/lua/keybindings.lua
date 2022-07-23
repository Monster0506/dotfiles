local M = {}

function M.setup()
    local opts = {noremap = true, silent = true}
    local keymap = vim.api.nvim_set_keymap

    -- Keybindings {{{
    -- Window Resizing/Movement {{{
    -- Resize splits
    keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
    keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
    keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
    keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)
    -- Change split orientation
    keymap("n", ",v", "<C-w>t<C-w>H", opts)
    keymap("n", ",h", "<C-w>t<C-w>K", opts)
    keymap("n", "<M-Right>", "<cmd>tabnext<CR>", opts)
    keymap("n", "<M-Left>", "<cmd>tabprevious<CR>", opts)
    --- }}}
    -- FZF {{{
    keymap("n", "<C-p>", "<cmd>Files<CR>", opts)
    keymap("n", "<leader><C-p>", "<cmd>Commands<CR>", opts)
    --- }}}
    -- Bracket expansion {{{
    keymap("i", "(<CR>", "(<CR>)<Esc>O", opts)
    keymap("i", "(;", "(<CR>);<Esc>O", opts)
    keymap("i", "(,", "(<CR>),<Esc>O", opts)
    keymap("i", "{<CR>", "{<CR>}<Esc>O", opts)
    keymap("i", "{;", "{<CR>};<Esc>O", opts)
    keymap("i", "{,", "{<CR>},<Esc>O", opts)
    keymap("i", "[<CR>", "[<CR>]<Esc>O", opts)
    keymap("i", "[;", "[<CR>];<Esc>O", opts)
    keymap("i", "[,", "[<CR>],<Esc>O", opts)
    --- }}}
    -- Center Text on the Screen {{{
    local remapList = {"p", "P", "<CR>", "gg", "H", "L", "n", "N", "%", "<c-o>"}

    for k in pairs(remapList) do
        keymap("n", remapList[k], remapList[k] .. "zz", opts)
        keymap("v", remapList[k], remapList[k] .. "zz", opts)
    end
    keymap("n", "j", "v:count == 0 ? 'gjzz' : 'jzz'", {silent = true, expr = true, noremap = true})
    keymap("n", "k", "v:count == 0 ? 'gkzz' : 'kzz'", {silent = true, expr = true, noremap = true})
    keymap("v", "j", "v:count == 0 ? 'gjzz' : 'jzz'", {silent = true, expr = true, noremap = true})
    keymap("v", "k", "v:count == 0 ? 'gkzz' : 'kzz'", {silent = true, expr = true, noremap = true})

    --- }}}
    -- Miscellaneous Mappings {{{
    keymap("n", "<C-a>", "ggVG", opts)
    keymap("i", ":check:", "✓", opts)
    keymap("n", "+", "<C-a>", opts)
    keymap("v", "<leader>y", '"+y', opts)
    keymap("n", "<C-t>", "<cmd>NvimTreeToggle<CR>", opts)
    keymap("n", "<space>t", "<cmd>FloatermToggle<CR>", opts)
    keymap("x", "<space>t", ":FloatermNew<CR>", opts)
    keymap("n", "<space>r", "<cmd>FloatermNew ranger<CR>", opts)
    keymap("n", "<F2>", "<cmd>setlocal spell! spelllang=en_us<CR>", opts)
    keymap("n", "<leader>t", "<cmd>Vista nvim_lsp<CR>", opts)
    keymap("n", "<leader>tag", "<cmd>Vista ctags<CR>", opts)
    keymap("n", "<Space>u", "<cmd>MundoToggle<CR>", opts)
    keymap(
        "n",
        "<leader>l",
        ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>",
        opts
    )
    keymap("x", "<", "<gv", opts)
    keymap("x", ">", ">gv", opts)
    keymap("c", "cd.", "lcd %:p:h<CR>", opts)
    keymap("c", "cwd", "lcd %:p:h<CR>", opts)
    --- }}}
    -- Leap Keybindings {{{
    keymap("n", "<leader><leader>s", "<Plug>(leap-forward)", opts)
    keymap("n", "<leader><leader>S", "<Plug>(leap-backward)", opts)
    keymap("v", "<leader><leader>s", "<Plug>(leap-forward)", opts)
    keymap("v", "<leader><leader>S", "<Plug>(leap-backward)", opts)
    --- }}}
    -- Telescope Mappings {{{
    keymap("n", "<space>h", "<cmd>History<CR>", opts)
    keymap("n", "<space>h/", "<cmd>History/<CR>", opts)
    keymap("n", "<space>h:", "<cmd>History:<CR>", opts)
    keymap("n", "<space>m", "<cmd>Maps<CR>", opts)
    keymap("n", "<space>b", "<cmd>Buffers<CR>", opts)
    keymap("n", "<space>w", "<cmd>Windows<CR>", opts)
    --- }}}
    -- LSP Mappings {{{
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
    --- }}}
    -- Git Keybindings {{{
    keymap("n", "<leader>g", "<CMD>G<CR>", opts)
    keymap("n", "<leader>gd", "<CMD>Gdiffsplit<CR>", opts)
    keymap("n", "<leader>g[", "<CMD>Gitsigns prev_hunk<CR>", opts)
    keymap("n", "<leader>g]", "<CMD>Gitsigns next_hunk<CR>", opts)
    keymap("n", "<leader>ga", "<CMD>G add %<CR>", opts)
    keymap("n", "<leader>gc", "<CMD>G commit<CR>", opts)
    keymap("n", "<leader>gr", "<CMD>G reset %<CR>", opts)
    keymap("n", "<leader>ghs", "<CMD>Gitsigns stage_hunk<CR>", opts)
    keymap("n", "<leader>ghu", "<CMD>Gitsigns undo_stage_hunk<CR>", opts)
    --- }}}
    --- }}}
end

return M
