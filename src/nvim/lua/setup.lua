#!/usr/bin/env lua

local M = {}
function M.run() -- {{{
    -- Nvim Comment
    require("Comment").setup()
    -- Crates for Rust
    require("crates").setup()
    -- Gitsigns
    require("gitsigns").setup()
    --🐕 picker
    require("icon-picker")
    -- Movement
    require("leap")

    require("config")
end

return M
