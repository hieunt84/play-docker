### Ref
    https://blog.vietnamlab.vn/quan-ly-docker-ez-voi-portainer/
    https://tel4vn.edu.vn/phan-2-cau-hinh-portainer-giam-sat-docker-tren-remote-host/
    https://www.portainer.io/blog/new-portainer-ce-2.6.0-release?utm_campaign=Portainer%20Community%20Program&utm_source=MOTD

### Portainer là gì
- phần mềm quản lý docker host
- quản lý tài nguyên: host, volume, network,...
- cài đặt ứng dụng với template có sẵn.
### Deploy
    # Tạo volume cho portainer
      docker volume create portainer_data

    # Tạo portainer container
      docker run -d -p 9000:9000 --name=portainer --restart=always \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v portainer_data:/data \
        portainer/portainer-ce

### Update
    # Stop portainer container
    docker stop portainer

    # Xoá portainer container
    docker rm -f portainer

    # Xoá portainer/portainer image
    docker image rm portainer/portainer

    # Pull latest portainer/portainer image và tạo lại container mới
    docker run -d -p 9000:9000 --name=portainer --restart=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v portainer_data:/data \
      portainer/portainer-ce
    