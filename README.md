# Dotfiles

macOS development environment managed with Homebrew and symlinks. The primary editor is Neovim.

## Bootstrap

1. Install Xcode Command Line Tools:

   ```sh
   xcode-select --install
   ```

2. Clone the repository:

   ```sh
   git clone <repository-url> "$HOME/.dotfiles"
   ```

3. Run the installer:

   ```sh
   cd "$HOME/.dotfiles"
   ./install.sh
   ```

`install.sh` installs Oh My Zsh, creates symlinks, installs the Brewfile, installs Neovim's Python support, configures the default shell, and applies macOS preferences. Review it before running it on a new machine.

## Day-To-Day Commands

```sh
./symlink.sh  # Create missing configuration symlinks
brew bundle   # Install or update Homebrew dependencies
```

Symlinking is safe to re-run: existing destinations are left unchanged.

## Linked Configuration

| Repository path | Destination |
| --- | --- |
| `git/gitconfig.symlink` | `~/.gitconfig` |
| `git/gitignore_global.symlink` | `~/.gitignore_global` |
| `zsh/zshrc.symlink` | `~/.zshrc` |
| `tmux/tmux.conf.symlink` | `~/.tmux.conf` |
| `config/nvim/` | `~/.config/nvim/` |
| `config/aerospace/` | `~/.config/aerospace/` |
| `config/ghostty/` | `~/.config/ghostty/` |
| `config/opencode/` | `~/.config/opencode/` |

All `*.symlink` files are linked as dotfiles in `$HOME`. Directories under `config/` are linked into `$HOME/.config`.

## Neovim

Neovim is configured with Lua, Lazy.nvim, Mason, and native Neovim LSP configuration.

- TypeScript and JavaScript: `vtsls`, using the workspace TypeScript version.
- Completion: `blink.cmp` with LSP auto-imports and Codeium/Windsurf ghost text.
- Diagnostics: ESLint LSP.
- Formatting and autofixes: Conform runs `eslint_d` followed by `prettierd` on save.
- Styling: Tailwind CSS LSP with `cva` and `cx` class detection.
- Tests: Neotest with Jest and Vitest adapters.
- Parsing: Treesitter with TypeScript, TSX, JavaScript, GraphQL, SQL, and related parsers.

The Treesitter plugin remains on its `master` compatibility branch; its `main` branch is an incompatible rewrite for this configuration.

## Repository Layout

```text
config/nvim/       Neovim configuration
config/aerospace/  AeroSpace window manager configuration
config/ghostty/    Ghostty terminal configuration
config/opencode/   OpenCode configuration and local skills
git/               Git configuration and global ignore rules
zsh/               Oh My Zsh configuration, theme, and plugins
Brewfile           Homebrew packages
install.sh         Full machine bootstrap
symlink.sh         Symlink setup only
osx.sh             macOS preference setup
```
