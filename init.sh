#!/usr/bin/env bash
clear
echo "About to unleash the beast!"
echo
echo "Enter admin password"

# Ask for sudo upfront
sudo -K
sudo true;

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Homebrew
if hash brew 2>/dev/null; then
  echo "Homebrew is already installed!"
else
  echo "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo
echo "Ensuring you have the latest Homebrew..."
brew update

echo
echo "Ensuring your Homebrew directory is writable..."
sudo chown -R $(whoami) /usr/local/bin

echo
echo "Installing Homebrew services..."
brew tap homebrew/services

echo
echo "Upgrading existing brews..."
brew upgrade

echo "Cleaning up your Homebrew installation..."
brew cleanup

echo
echo "Adding Homebrew's sbin to your PATH..."
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile

echo

# cask and wget
brew tap caskroom/cask
brew install wget

# zsh and oh-my-zsh
brew install zsh zsh-completions
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Core Apps
brew cask install iterm2
brew cask install java
brew cask install vlc
brew cask install gimp

# Browsers
brew cask install google-chrome
# brew cask install firefox

# Communication
brew cask install slack

# Dev Tools
brew install git
brew cask install visual-studio-code
brew cask install insomnia
brew cask install macdown
brew install heroku-toolbelt
brew cask install expo-xde
heroku update
brew install docker
brew cask install postgres

# Node.js
brew install node
brew install postgres
brew install redis
brew cask install mongodb
brew install yarn

# PHP
# brew install php

# # Android Development
# brew cask install android-sdk
# brew cask install android-studio
# brew cask install vysor

# NPM Global Packages
yarn global add sequelize-cli
yarn global add nodemon
yarn global add pm2
yarn global add create-react-app
yarn global add create-react-native-app
yarn global add react-native-cli
yarn global add mocha
yarn global add jest
yarn global add firebase-tools
yarn global add aws-sdk
yarn global add vue-cli
yarn global add express-generator
yarn global add exp

# Cleanup
brew cleanup

# Change default shell to zsh
chsh -s $(which zsh)

echo
echo "Done!"
