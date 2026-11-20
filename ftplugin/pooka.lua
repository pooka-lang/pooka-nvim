vim.b.pooka = true
vim.bo.commentstring = "// %s"
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

local pooka = require("pooka")
if pooka.parser_available() then
  pcall(vim.treesitter.start)
else
  vim.bo.syntax = "pooka"
end
