local M = {}

local language = "pooka"
local repository = "https://github.com/pooka-lang/tree-sitter-pooka"
local revision = "d7412722bdb1f60d34ebdd30426bdd613bbb41ba"

vim.filetype.add({
  extension = { pooka = "pooka" },
})

if vim.treesitter and vim.treesitter.language then
  pcall(vim.treesitter.language.register, language, language)
end

function M.parser_available()
  if not vim.treesitter or not vim.treesitter.language then
    return false
  end
  local ok, added = pcall(vim.treesitter.language.add, language)
  if not ok or added == false then
    return false
  end
  local inspected, parser = pcall(vim.treesitter.language.inspect, language)
  return inspected and parser ~= nil
end

local function run(args, opts)
  local result = vim.system(args, opts or {}):wait()
  if result.code ~= 0 then
    error(("%s failed: %s"):format(args[1], (result.stderr or ""):gsub("%s+$", "")))
  end
  return result.stdout
end

function M.install_grammar()
  if not vim.system then
    error("PookaInstallGrammar needs Neovim 0.10 or newer")
  end

  local root = vim.fn.stdpath("data") .. "/pooka/tree-sitter-pooka"
  local parsers = vim.fn.stdpath("data") .. "/site/parser"
  vim.fn.mkdir(parsers, "p")

  if vim.fn.isdirectory(root .. "/.git") == 0 then
    run({ "git", "clone", "--filter=blob:none", repository, root })
  end
  run({ "git", "fetch", "--depth", "1", "origin", revision }, { cwd = root })
  run({ "git", "checkout", "--detach", revision }, { cwd = root })
  -- ABI 14 also works on Neovim 0.10, whose runtime cannot load ABI 15.
  run({ "tree-sitter", "generate", "--abi", "14" }, { cwd = root })
  run({ "tree-sitter", "build", "--output", parsers .. "/pooka.so" }, { cwd = root })

  vim.notify("Pooka grammar installed; restart Neovim to use Tree-sitter highlighting", vim.log.levels.INFO)
end

return M
