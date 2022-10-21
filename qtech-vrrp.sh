#!/bin/bash

PRIMARY_IP=$(ip -4 addr | sed -ne 's|^.* inet \([^/]*\)/.* scope global.*$|\1|p' | awk '{print $1}' | head -1)
read -rp "Primary (current) WLC IPv4 address: " -e -i "${PRIMARY_IP}" PRIMARY_IP
read -rp "Secondary WLC IPv4 address: " -e -i "${SECONDARY_IP}" SECONDARY_IP
	
SERVER_NIC="$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)"
until [[ ${SERVER_NIC} =~ ^[a-zA-Z0-9_]+$ ]]; do
	read -rp "Public interface: " -e -i "${SERVER_NIC}" SERVER_NIC
done
 
# Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose keepalived -y
sudo systemctl enable --now docker
# Navigator
curl -sSL https://repo.45drives.com/setup | sudo bash
sudo dnf install cockpit-navigator -y
# Wimark
URL=$(wget -nv -O- https://www.qtech.ru/catalog/wireless/lan_controllers/qwc_wm/#documentation | grep -Po 'https:\/\/files\.qtech\.ru\/upload\/wireless\/QWC-VC\/QWC-VC-[\d\.]+-HA-\d{2}-\d{2}-\d{4}-installer\.zip')
wget -O QWC-VC-HA-installer.zip $URL
unzip -q QWC-VC-HA-installer.zip
sudo bash QWC-VC-*-installer.run --target /home/$(whoami)/QWC-VC-HA-installer
ssh $(whoami)@$SECONDARY_IP
# ssh
ssh-keygen
cat ~/.ssh/id_rsa.pub | ssh $(whoami)@$SECONDARY_IP "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
sudo wget https://raw.githubusercontent.com/32fca06c/qtech/main/master-backup.sh -o /etc/wimark/master-backup.sh
sudo chmod ug+x /etc/wimark/master-backup.sh
# Keepalived
sudo systemctl enable --now keepalived
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo echo "net.ipv4.ip_nonlocal_bind = 1" >> /etc/sysctl.conf; sysctl -p
