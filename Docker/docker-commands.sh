## docker container commands 
# assume image_name=nginx

docker container run -d --name=web_container  nginx                             # -d detached mode
docker container run -d --name=web_container --hostname=nginx_server  nginx     # set a hostname
docker container run -it --name=web_container nginx  /bin/bash                  # -it interactive mode

# port mapping -p <host_port>:<container_port>
docker container run -d --name=web_container -p 8080:80 nginx     

# container logs
docker logs -f container_name

# inspect (for troubleshooting)
docker inspect container_name
docker container stats
docker system info
docker system df

# execute command in a running container
docker exec -it container_name /bin/bash

docker start container_name
docker stop  container_name
docker restart container_name

docker rm container_name        # remove container
docker rm -f container_name     # remove running container
docker container prune          # remove all stopped containers

# restart policies
docker container run --restart=no               # never automatically restarted
docker container run --restart=on-failure       # restart only when it fails (exit status != 0)
docker container run --restart=always           # restart always ( if manually stopped it will restart when daemon restart )
docker container run --restart=unless-stopped   # restart always ( if manually stopped it will start manually )

# docker live restore ( container will still run even if docker daemon stopped )
# minimizing downtime during daemon restart/crash, not for keeping host port publishing
vim /etc/docker/daemon.json
    {
        "live-restore": true
    }


# create new image from running container
# use it if we make a custom changes inside container
# docker container commit -a <author> <container_name> <new_image_name>
docker container commit -a "mansi" nginx custom_nginx


## docker image commands 

docker image ls -a
docker image pull nginx

docker image rm image_name
docker image prune

docker image pull nginx
docker history nginx

docker image build -t muhammadelmansi/flask-app:v1.0 .

## docker networking

docker network ls
docker network create -d bridge --subnet 192.168.100.0 network_name         # bridge, host, none
docker container run -d --network=network_name --name=container_name nginx

docker network connect network_name container_name
docker network disconnect network_name container_name
docker network remove network_name

## docker volumes

docker volume ls
docker volume create volume_name
docker run -d -v volume_name:/path --name=container_name nginx

## dockerhub
docker login -u muhammadelmansi         # then enter token that was generated from dockerhub site
