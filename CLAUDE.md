# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository that manages system configuration through symbolic links and automated setup scripts. The repository uses Oh My Zsh with custom themes and plugins, Neovim as the primary editor, and Homebrew for package management.

## Setup and Installation Commands

**Initial Setup:**

```bash
./install.sh
```

This is the main installation script that:

- Installs Oh My Zsh
- Creates symbolic links via `symlink.sh`
- Installs Homebrew and packages from `Brewfile`
- Sets up Neovim with Python support
- Configures macOS settings via `osx.sh`
- Sets proper SSH permissions

**Manual VSCode Setup:**
VSCode requires manual symlink creation:

```bash
ln -s /Users/christophvanhees/.dotfiles/VSCode/settings.json "/Users/christophvanhees/Library/Application Support/Code/User/settings.json"
ln -s /Users/christophvanhees/.dotfiles/VSCode/keybindings.json "/Users/christophvanhees/Library/Application Support/Code/User/keybindings.json"
```

Note: VSCode snippets directory is not currently present in the repository.

**Package Management:**

```bash
brew bundle               # Install packages from Brewfile
brew update               # Update Homebrew
```

**Development Tools:**

```bash
pip3 install pynvim       # Neovim Python support
composer global require laravel/installer laravel/valet  # PHP tools
npm install --global yarn now doctoc  # Node.js tools
```

## Architecture and Structure

### Symlink System

The repository uses a dual-symlink approach:

1. **`.symlink` files**: Found in subdirectories, automatically linked to `~/.<basename>`
2. **`config/` directory**: Contents linked to `~/.config/`

**Current symlinked files:**

- `git/gitconfig.symlink` → `~/.gitconfig`
- `git/gitignore_global.symlink` → `~/.gitignore_global`
- `zsh/zshrc.symlink` → `~/.zshrc`
- `tmux/tmux.conf.symlink` → `~/.tmux.conf`
- `config/nvim/` → `~/.config/nvim/`

### Neovim Configuration

**Location:** `config/nvim/`

- Uses Lua configuration with Lazy.nvim plugin manager
- Main config: `init.lua`
- Personal config: `lua/chrizzmeister/`
- Plugin configs: `lua/plugins/` and `after/plugin/`
- Includes Blade syntax highlighting for Laravel

**Key Neovim files:**

- `config/nvim/init.lua` - Main configuration entry point
- `config/nvim/lua/config/lazy.lua` - Lazy.nvim plugin manager setup
- `config/nvim/lua/plugins/` - Modular plugin configurations
- `config/nvim/lua/chrizzmeister/remap.lua` - Key mappings
- `config/nvim/lua/chrizzmeister/set.lua` - Editor settings
- `config/nvim/lazy-lock.json` - Plugin version lockfile

### Zsh Configuration

**Main config:** `zsh/zshrc.symlink`

- Uses Oh My Zsh framework
- Spaceship theme for enhanced prompt
- Custom plugins: zsh-autosuggestions, alias-tips

**Plugin locations:**

- `zsh/plugins/zsh-autosuggestions/` - Command suggestions
- `zsh/plugins/alias-tips/` - Alias reminders
- `zsh/themes/spaceship-prompt/` - Spaceship theme

### Development Environment

**Supported Languages/Tools:**

- PHP (with Laravel Valet)
- Node.js (with NPM)
- Python (with pip3)
- Git (with global config)
- Tmux (terminal multiplexer)
- Docker (lazydocker for management)

**Key Brewfile packages:**

- Core: `git`, `zsh`, `tmux`, `neovim`, `fzf`, `ripgrep`
- Development: `php`, `node`, `python`
- Tools: `lazydocker`, `the_silver_searcher`, `ack`

**Additional files:**

- `composer.phar` - PHP Composer dependency manager
- `tmux/base16.sh` - Base16 color scheme for tmux
- `.claude/` - Claude Code configuration directory

### VSCode Integration

**Location:** `VSCode/`

- Requires manual symlink setup (no auto-linking)
- Includes settings and keybindings
- Must be linked to `~/Library/Application Support/Code/User/`

## macOS Customization

The `osx.sh` script configures:

- Finder: Show extensions, path bar, status bar
- Safari: Enable debug menu
- Dock: Auto-hide behavior

## Directory Structure for Projects

The installation creates:

- `~/Documents/Projects/` - General projects
- `~/Documents/Personal-projects/` - Personal projects

