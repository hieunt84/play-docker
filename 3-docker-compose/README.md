### Giới thiệu docker-compose
- là công cụ dùng để triển khai ứng dụng gồm nhiều container liên kết với nhau.

### command docker-compose
```console
docker-compose up -d
docker-compose rm
docker-compose ps
docker-compose exec [service-name] [command]
  example: docker-compose exec mariadb \
     /usr/bin/mysqldump -u root --password=owncloud \
     owncloud > owncloud_db_$(date +%Y%m%d).sql

docker-compose stop
docker-compose down
docker-compose down --rmi all --volumes
```