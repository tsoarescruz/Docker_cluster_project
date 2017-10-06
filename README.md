# README


This document`s a end of TCC graduation of UVA - Universidade Veiga de Almeida
This documment references main steps to Docker - Swiss Army in  Rasperry Pi:

* Ruby version

* System dependencies

* Configuration

* Database creation

 * Comando with read database config inside the project:
bundle exec rails db:reset -> drop + create + migrate + seed


* Database initialization


* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Configuration

* Main Docker commands
 * Exec command inside container directly
docker run --name=test-mysql --env="MYSQL_ROOT_PASSWORD=password" mysql

 * Clean Volume
docker volume rm $(docker volume ls -qf dangling=true)

 * Inspect Container
 docker inspect phalanx_db_1

 * Service visualizer bound host network with container netowrk
docker run -it -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock alexellis2/visualizer-arm
s