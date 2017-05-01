docker-build:
  @docker run --name mysql-server -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d mysql

  @docker build -t phalanx .
  @docker run --name phalanx --link mysql-server:mysql --expose 3000 -p 3000:3000/tcp -e DATABASE_HOST=mysql -e DATABASE_USER=root -e RAILS_ENV=production -it phalanx

docker-start:
  @docker start mysql-server
  @docker start phalanx

docker-stop:
  @docker stop phalanx
  @docker stop mysql-server
