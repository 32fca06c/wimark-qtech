#!/bin/bash

# Detect public IPv4 or IPv6 address and pre-fill for the user
	SERVER_PUB_IP=$(ip -4 addr | sed -ne 's|^.* inet \([^/]*\)/.* scope global.*$|\1|p' | awk '{print $1}' | head -1)
	read -rp "IPv4: " -e -i "${SERVER_PUB_IP}" SERVER_PUB_IP

	# Detect public interface and pre-fill for the user
	SERVER_NIC="$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)"
	until [[ ${SERVER_PUB_NIC} =~ ^[a-zA-Z0-9_]+$ ]]; do
		read -rp "Public interface: " -e -i "${SERVER_NIC}" SERVER_PUB_NIC
	done
  
# Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose keepalived -y
sudo systemctl enable --now docker
# Navigator
curl -sSL https://repo.45drives.com/setup | sudo bash
sudo dnf install cockpit-navigator -y
# Wimark
wget https://files.qtech.ru/upload/wireless/QWC-VC/QWC-VC-1.8.1-19-08-2022-installer.zip
unzip -q QWC-VC-1.8.1-19-08-2022-installer.zip
rm QWC-VC-1.8.1-19-08-2022-installer.zip
# ssh
ssh-keygen
cat ~/.ssh/id_rsa.pub | ssh $(whoami)@remote_host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
sudo wget https://raw.githubusercontent.com/32fca06c/qtech/main/master-backup.sh -o /etc/wimark/master-backup.sh
sudo chmod ug+x /etc/wimark/master-backup.sh
# Keepalived
sudo systemctl enable --now keepalived
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo echo "net.ipv4.ip_nonlocal_bind = 1" >> /etc/sysctl.conf; sysctl -p
