# Pooka for Neovim

Pooka source and spec highlighting, with Tree-sitter when a parser is available and regex highlighting when it is not.

## Install locally

Copy this directory to your Neovim packages directory, for example `~/.local/share/nvim/site/pack/plugins/start/pooka-nvim`. It works as an ordinary runtime package. Enable filetype plugins and syntax in your configuration:

```lua
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
```

`.pooka` and `.spec.pooka` use the same filetype.

## Tree-sitter

On Neovim 0.10+, with Git, the Tree-sitter CLI and a C compiler installed:

```vim
:PookaInstallGrammar
```

This fetches its own pinned [tree-sitter-pooka](https://github.com/pooka-lang/tree-sitter-pooka) revision into Neovim's data directory and compiles the parser. Restart Neovim afterwards. No neighbouring source checkout is used. Without the parser, the regex fallback still works.

## Language server

On Neovim 0.11+, install a compiler build that includes `pooka lsp` and add this to your configuration:

```lua
vim.lsp.config("pooka", {
  cmd = { "pooka", "lsp" },
  filetypes = { "pooka" },
  root_markers = { "pooka.toml" },
})
vim.lsp.enable("pooka")
```

If needed, replace the first `cmd` element with the absolute compiler path. Open a Pooka file under `pooka.toml` and run `:checkhealth vim.lsp` to check the connection. Use `vim.lsp.buf.definition()` to navigate and `vim.lsp.buf.format()` to format. If dependencies are missing, run `pooka deps download` in the project and save a Pooka file.

## Development

Edit `syntax/pooka.vim` and `queries/pooka/*.scm` directly. The plugin owns these files. Run from this directory:

```sh
nvim --headless -u NONE -l tests/check.lua
```

The checks cover file detection, comment settings, fallback highlighting and Tree-sitter query compilation when the parser is installed. CI checks both highlighting paths.

## Licence

Apache-2.0. See [LICENSE](LICENSE).
