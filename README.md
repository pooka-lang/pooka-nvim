# Pooka for Neovim

Pooka source and spec highlighting, with Tree-sitter when a parser is available and regex highlighting when it is not.

## Install locally

Copy this directory to your Neovim packages directory, for example `~/.local/share/nvim/site/pack/plugins/start/pooka-nvim`. It works as an ordinary runtime package. Enable filetype plugins and syntax in your configuration:

```lua
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
```

No compiler or language server is started. `.pooka` and `.spec.pooka` use the same filetype.

## Tree-sitter

On Neovim 0.10+, with Git, the Tree-sitter CLI and a C compiler installed:

```vim
:PookaInstallGrammar
```

This fetches its own pinned [tree-sitter-pooka](https://github.com/pooka-lang/tree-sitter-pooka) revision into Neovim's data directory and compiles the parser. Restart Neovim afterwards. No neighbouring source checkout is used. Without the parser, the regex fallback still works.

## Development

Edit `syntax/pooka.vim` and `queries/pooka/*.scm` directly. The plugin owns these files. Run from this directory:

```sh
nvim --headless -u NONE -l tests/check.lua
```

The checks cover file detection, comment settings, fallback highlighting and Tree-sitter query compilation when the parser is installed. CI checks both highlighting paths.

## Licence

Apache-2.0. See [LICENSE](LICENSE).
