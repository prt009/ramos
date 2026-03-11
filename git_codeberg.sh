#!/usr/bin/env bash

echo "hmm git installation now.. we will set up the mail and name globally"
if [[ $ID -eq "arch" ]]; then
  sudo pacman -S git openssh --needed
else
  echo "use your own package manager to install openssh and git."
fi

echo "[-------git setup-------]"
read -p "enter the desired email: " umail
git config --global user.email "$(umail)"
echo "the email $(umail) has been setup."
read -p "enter the desired username: " usname
git config --global user.name "$(usname)"

echo ""
echo "[-------ssh keygens setup-------]"
echo "now setting up ssh-keygens.."
ssh-keygen -t ed25519 -C "$(umail)"
eval "$(ssh-agent -s)"
echo "enabled ssh-agent"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub | wl-copy
echo "the public key has been copied..paste it in the platform of ur choice..personally i'd go to codeberg"
read -p "enter host url of the platform (leave blank if codeberg.org)" plat
if [[ $plat != "" ]]; then
  git -T git@codeberg.
else
  git -T git@$plat
fi
