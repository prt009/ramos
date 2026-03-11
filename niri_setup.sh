#!/usr/bin/env bash

sudo pacman -S --needed fuzzel swaybg xwayland-satellite ttf-jetbrains-mono-nerd waybar swayidle
yay -S --needed niri
sudo pacman -S xdg-desktop-portal-gtk xdg-desktop-portal-gnome --needed

dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'
