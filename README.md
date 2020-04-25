### Setting up your Mac

1. Update macOS to the latest version with the App Store
2. Install Xcode from the App Store, open it and accept the license agreement
3. Install macOS Command Line Tools by running `xcode-select --install`
4. Copy public and private SSH keys to `~/.ssh` and make sure they're set to `600`
5. Clone this repo to `~/.dotfiles`
6. Run `install.sh` to start the installation
7. Restart your computer to finalize the process

Your Mac is now ready to use!

> Note: you can use a different location than `~/.dotfiles` if you want. Just make sure you also update the reference in the `.zshrc` file.

## Vim and Neovim Setup

[Neovim](https://neovim.io/) is a fork and drop-in replacement for vim. in most cases, you would not notice a difference between the two, other than Neovim allows plugins to run asynchronously so that they do not freeze the editor, which is the main reason I have switched over to it. Vim and Neovim both use Vimscript and most plugins will work in both (all of the plugins I use do work in both Vim and Neovim). For this reason, they share the same configuration files in this setup. Neovim uses the [XDG base directory specification](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) which means it won't look for a `.vimrc` in your home directory. Instead, its configuration looks like the following:

|                         | Vim        | Neovim                    |
|-------------------------|------------|---------------------------|
| Main Configuration File  | `~/.vimrc` | `~/.config/nvim/init.vim` |
| Configuration directory | `~/.vim`   | `~/.config/nvim`          |

### VSCODE
Vscode does not work with automatic symlinking.

Commands to symlink settings:
```bash
ln -s /Users/christophvanhees/.dotfiles/VSCode/settings.json /Users/christophvanhees/Library/Application\ Support/Code/User/settings.json
```

```bash
ln -s /Users/christophvanhees/.dotfiles/VSCode/keybindings.json /Users/christophvanhees/Library/Application\ Support/Code/User/keybindings.json
```
```bash
ln -s /Users/christophvanhees/.dotfiles/VSCode/snippets/ /Users/christophvanhees/Library/Application\ Support/Code/User
```