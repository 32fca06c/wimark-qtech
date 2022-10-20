#!/bin/bash
# Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose -y
sudo systemctl enable --now docker
# Navigator
curl -sSL https://repo.45drives.com/setup | sudo bash
sudo dnf install cockpit-navigator -y
# Wimark
wget https://files.qtech.ru/upload/wireless/QWC-VC/QWC-VC-1.8.1-19-08-2022-installer.zip
unzip -q QWC-VC-1.8.1-19-08-2022-installer.zip
rm QWC-VC-1.8.1-19-08-2022-installer.zip
sudo bash QWC-VC-1.8.1-19-08-2022-installer.run
