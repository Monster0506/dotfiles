local command = vim.api.nvim_create_user_command
local opts = {bang = true}
-- Commands {{{
command("W", ":w", opts)
command("WQ", ":wq", opts)
command("WQa", ":wqa", opts)
command("Wq", ":wq", opts)
command("Wqa", ":wqa", opts)
command("Q :", "q", opts)
command("Noh", ":noh", opts)
command("Nog", ":noh", opts)
command("Ni", ":echo 'Do you demand a shrubbery?'", opts)
--- }}}
