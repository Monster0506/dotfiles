-- Nvim Comment
require("Comment").setup()
-- Crates for Rust
require("crates").setup()
-- Gitsigns
require("gitsigns").setup()
--🐕 picker
require("icon-picker")
-- Movement
---@diagnostic disable-next-line: different-requires
require("leap")
-- Luasnip
require("luasnip.loaders.from_snipmate").load()
