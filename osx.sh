#!/usr/bin/env bash

echo -e "\\n\\nSetting OS X settings"
echo "=============================="

# echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# echo "show hidden files by default"
defaults write com.apple.Finder AppleShowAllFiles -bool false

echo "Use current directory as default search scope in Finder"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

echo "Show Status bar in Finder"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

defaults write com.apple.dock autohide -bool true
echo "Automatically hide and show the Dock."