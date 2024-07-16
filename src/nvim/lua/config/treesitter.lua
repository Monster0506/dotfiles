--- Treesitter Settings {{{
require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "c",
        "vim",
        "vimdoc",
        "lua",
        "rust",
        "python",
        "cpp",
        "typescript",
        "javascript",
        "bash",
        "markdown",
        "clojure",
        "regex",
        "toml"
    },
    sync_install = false,
    ignore_install = {},
    modules = {},
    auto_install = true,
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 1024 * 10
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>"
        }
    }
}
--- }}}
-- vim:foldmethod=marker foldlevel=0
