#!/bin/bash
sudo docker stop $(sudo docker ps -a -q)
sudo docker container rm $(sudo docker ps -a -q)
wget https://files.qtech.ru/upload/wireless/QWC-VC/QWC-VC-1.8.1-19-08-2022-installer.zip
unzip -q QWC-VC-1.8.1-19-08-2022-installer.zip
rm QWC-VC-1.8.1-19-08-2022-installer.zip
sudo bash QWC-VC-1.8.1-19-08-2022-installer.run
