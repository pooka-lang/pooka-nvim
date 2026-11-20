if vim.g.loaded_pooka then
  return
end
vim.g.loaded_pooka = 1

local pooka = require("pooka")

vim.api.nvim_create_user_command("PookaInstallGrammar", function()
  pooka.install_grammar()
end, {
  desc = "Compile the Pooka Tree-sitter grammar into the Neovim parser directory",
})
