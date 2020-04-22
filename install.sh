#!/bin/sh

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles..."

source symlink.sh

# Check for Homebrew and install if we don't have it
  if test ! "$( command -v brew )"; then
      echo "Installing homebrew"
      ruby -e "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install )"
  fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# after the install, install neovim python libraries
echo -e "\\n\\nRunning Neovim Python install"
echo "=============================="
pip3 install pynvim

# Install PHP extensions with PECL
pecl install imagick

# Change the default shell to zsh
zsh_path="$( command -v zsh )"
if ! grep "$zsh_path" /etc/shells; then
    echo "adding $zsh_path to /etc/shells"
    echo "$zsh_path" | sudo tee -a /etc/shells
fi

if [[ "$SHELL" != "$zsh_path" ]]; then
    chsh -s "$zsh_path"
    echo "default shell changed to $zsh_path"
fi

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/valet

# Install global NPM packages
npm install --global yarn now doctoc

# Create a Projects directory
mkdir $HOME/Documents/Projects
mkdir $HOME/Documents/Personal-projects

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
