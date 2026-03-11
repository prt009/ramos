#!/bin/sh

. /etc/os-release

set -eo pipefail

echo "hmm git installation now.. we will set up the mail and name globally"
if [[ $ID -eq "arch" ]]; then
  sudo pacman -S git openssh --needed
else
  echo "use your own package manager to install openssh and git."
fi

echo "[-------git setup-------]"
while true; do
  read -rp "enter your desired email: " email
  if [[ -n "$email" ]]; then
    break
  else
    echo "email cannot be empty."
  fi
done

while true; do
  read -p "enter the desired username: " usname
  if [[ -n "$usname" ]]; then
    break
  else
    echo "username required"
  fi
done
git config --global user.email "$email"
git config --global user.name "$usname"
echo "$email and $usname has been setup"

echo
echo "git has been setup successfully"
echo

git config --global --list | grep user

echo ""
echo "[-------ssh keygens setup-------]"
echo "now setting up ssh-keygens.."
ssh-keygen -t ed25519 -C "$email"
eval "$(ssh-agent -s)"
echo "enabled ssh-agent"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub | wl-copy
echo "the public key has been copied..paste it in the platform of ur choice..personally i'd go to codeberg"
read -p "enter host url of the platform (leave blank if codeberg.org)" plat
if [[ $plat != "" ]]; then
  git -T git@codeberg.org
else
  git -T "git@$plat"
fi
