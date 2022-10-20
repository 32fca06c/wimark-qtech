#!/bin/bash
# Docker
sudo dnf install dnf-plugins-core -y
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io -y
sudo dnf install docker-compose -y
sudo systemctl enable --now docker
# Keepalived
sudo dnf install keepalived -y
# ssh
ssh-keygen
cat ~/.ssh/id_rsa.pub | ssh user@remote_host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" 
wget https://files.qtech.ru/upload/wireless/QWC-VC/QWC-VC-1.8.1-19-08-2022-installer.zip
unzip QWC-VC-1.8.1-19-08-2022-installer.zip
sudo https://raw.githubusercontent.com/32fca06c/qtech/main/master-backup.sh -o /etc/wimark/master-backup.sh
sudo chmod ug+x /etc/wimark/master-backup.sh
# Keepalived
sudo systemctl enable --now keepalived
