# AGENTS.md

Guidance for AI agents working in this repository.

`CLAUDE.md` is a symlink to this file (for Anthropic / Claude Code tooling that looks for that name).

## Repository overview

macOS dotfiles repo. Config is applied via symlinks (`symlink.sh`) and Homebrew (`Brewfile`). Primary editor is Neovim (Lua + Lazy.nvim). Daily stack is TypeScript / React / GraphQL / Node — not PHP.

## Setup

```bash
./install.sh          # Oh My Zsh, symlinks, Homebrew bundle, pynvim, npm globals, osx prefs
./symlink.sh          # Symlinks only (safe to re-run; skips existing targets)
brew bundle           # Install/update from Brewfile
```

VSCode is **not** auto-linked:

```bash
ln -s "$HOME/.dotfiles/VSCode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
ln -s "$HOME/.dotfiles/VSCode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
```

## Symlink system

1. `**/*.symlink` → `~/.<basename>` (e.g. `zsh/zshrc.symlink` → `~/.zshrc`)
2. `config/<name>/` → `~/.config/<name>/` (e.g. `config/nvim` → `~/.config/nvim`, `config/aerospace` → `~/.config/aerospace`)

Existing targets are skipped — remove the destination first if you need to replace it.

### Linked today

| Repo path | Destination |
|---|---|
| `git/gitconfig.symlink` | `~/.gitconfig` |
| `git/gitignore_global.symlink` | `~/.gitignore_global` |
| `zsh/zshrc.symlink` | `~/.zshrc` |
| `tmux/tmux.conf.symlink` | `~/.tmux.conf` |
| `config/nvim/` | `~/.config/nvim/` |
| `config/aerospace/` | `~/.config/aerospace/` (`aerospace.toml`) |

## Layout

```
config/nvim/          Neovim (Lazy.nvim)
config/aerospace/     AeroSpace WM
zsh/                  Oh My Zsh custom (theme, plugins) + zshrc.symlink
git/                  gitconfig + global gitignore
tmux/                 tmux.conf.symlink
VSCode/               settings + keybindings (manual symlink)
Brewfile              Homebrew packages
install.sh / symlink.sh / osx.sh
```

## Neovim

**Path:** `config/nvim/`

- Entry: `init.lua` → `lua/chrizzmeister/`
- Plugins: `lua/chrizzmeister/plugins/*.lua`
- Lockfile: `lazy-lock.json`
- Treesitter: pin `branch = "master"` (old API; `main` is an incompatible rewrite)

Notable stack:

| Concern | Tool |
|---|---|
| TS/JS LSP | `typescript-tools.nvim` (not `ts_ls`) |
| Completion | `blink.cmp` (+ capabilities on LSP clients) |
| Format / lint-fix | `conform.nvim`: `eslint_d` then `prettierd` on save |
| ESLint diagnostics | `eslint` LSP (`format = false`) |
| Tailwind | `tailwindcss` LSP (document colors disabled) |
| AI | Windsurf (Codeium); Copilot disabled to avoid dual Node daemons |

When changing LSP/formatters, keep Mason `ensure_installed` in sync via `opts.servers` keys and conform `formatters_by_ft`.

## Zsh

`zsh/zshrc.symlink` — Oh My Zsh, Spaceship theme, plugins under `zsh/plugins/` and `zsh/themes/`.

## Conventions for agents

- Prefer small, targeted edits; match existing Lua/style.
- Do not commit unless asked.
- Do not force-push or skip hooks unless explicitly requested.
- Avoid reintroducing PHP/Laravel/Composer tooling — removed on purpose.
- AeroSpace config lives at `config/aerospace/aerospace.toml` (XDG path after symlink).
