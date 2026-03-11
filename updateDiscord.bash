#!/usr/bin/env bash

dir="$HOME/.local/bin/Discord/"

deleteDiscord() {
  echo "deleting discord..."
  rm -rf ~/.local/bin/Discord
  rm ~/.local/share/applications/discord.desktop
  echo "local files deleted..."
  sudo rm /usr/bin/Discord
  sudo rm /usr/share/applications/discord.desktop
  sudo rm /usr/share/icons/discord.png
  echo "usr files deleted.. Done"
}
installDiscord() {
  cd ~/
  mkdir -p ~/.local/bin
  wget "https://discord.com/api/download?platform=linux&format=tar.gz" -O discord.tar.gz
  tar -xvf discord.tar.gz -C ~/.local/bin
  sudo ln -s ~/.local/bin/Discord/discord.png /usr/share/icons/discord.png
  sudo ln -s ~/.local/bin/Discord/Discord /usr/bin
  wget https://raw.githubusercontent.com/dewpeye/curler/refs/heads/main/discord.desktop -O discord.desktop
  mkdir -p ~/.local/share/applications/
  mv ~/discord.desktop ~/.local/share/applications/
  sudo ln -s ~/.local/share/applications/discord.desktop /usr/share/applications/discord.desktop
  rm ~/discord.tar.gz
}
if [ -d $dir ]; then
  echo "discord already exists."
  deleteDiscord
  installDiscord
else
  echo "discord doesn't exist .. installing.."
  installDiscord
fi
