-- SPDX-License-Identifier: Apache-2.0
local root = vim.fn.getcwd()
vim.opt.runtimepath:prepend(root)
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')
vim.cmd('runtime plugin/pooka.lua')
for _, name in ipairs({ 'hello.pooka', 'hello.spec.pooka' }) do
  vim.cmd('edit ' .. name)
  assert(vim.bo.filetype == 'pooka', 'filetype detection: ' .. name)
  assert(vim.bo.commentstring == '// %s', 'comment string')
  assert(vim.bo.shiftwidth == 2, 'two-space indentation')
  vim.cmd('bwipeout!')
end
assert(vim.fn.exists(':PookaInstallGrammar') == 2, 'grammar installation command')
vim.cmd('enew')
vim.bo.filetype = 'pooka'
-- Force the fallback too, even when this test is run with a parser installed.
vim.cmd('syntax clear')
vim.b.current_syntax = nil
vim.cmd('runtime syntax/pooka.vim')
vim.api.nvim_buf_set_lines(0, 0, -1, false, { 'native Bridge', '// actor', 'let n = 0x2A' })
local function group(line, column)
  return vim.fn.synIDattr(vim.fn.synID(line, column, 1), 'name')
end
assert(group(1, 1) == 'pookaKeyword', 'native keyword')
assert(group(2, 4) == 'pookaComment', 'comment boundary')
assert(group(3, 9) == 'pookaNumber', 'hexadecimal number')
local pooka = require('pooka')
if pooka.parser_available() then
  for _, name in ipairs({ 'highlights', 'indents' }) do
    local query = table.concat(vim.fn.readfile(root .. '/queries/pooka/' .. name .. '.scm'), '\n')
    assert(vim.treesitter.query.parse('pooka', query), name .. ' query')
  end
  vim.cmd('edit tests/sample.spec.pooka')
  local parser = vim.treesitter.get_parser(0, 'pooka')
  assert(not parser:parse()[1]:root():has_error(), 'sample parses')
  print('Pooka: fallback and Tree-sitter checks passed')
else
  print('Pooka: fallback checks passed (no Tree-sitter parser installed)')
end
vim.cmd('qa!')
