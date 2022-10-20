sudo docker stop $(sudo docker ps -a -q)
sudo docker container rm $(sudo docker ps -a -q)
