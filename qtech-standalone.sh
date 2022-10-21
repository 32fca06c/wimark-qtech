#!/bin/bash
# Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose -y
sudo systemctl enable --now docker
# Wimark
URL=$(wget -nv -O- https://www.qtech.ru/catalog/wireless/lan_controllers/qwc_wm/#documentation | grep -Po 'https:\/\/files\.qtech\.ru\/upload\/wireless\/QWC-VC\/QWC-VC-[\d\.]+-\d{2}-\d{2}-\d{4}-installer\.zip')
wget -O QWC-VC-installer.zip $URL
unzip -q QWC-VC-installer.zip
rm QWC-VC-installer.zip
sudo bash QWC-VC-*-installer.run
