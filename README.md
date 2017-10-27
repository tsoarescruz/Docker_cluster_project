# README

This document`s a end of TCC graduation of UVA - Universidade Veiga de Almeida
This documment references main steps to Docker - Swiss Army in  Rasperry Pi:

 

<h4>Ruby</h4>
* Ruby version
 - 2.33

<h2> Software Configuration</h2>
<h3>* Create Application</h3>
<pre>rails new Phalanx</pre>

<h3>* Database create</h3>
<h4>* Command create database, config inside the project:</h4>
<pre>rails db:create</pre>

<h3>* Database Configuration</h3>
<h4>* Command create database, config inside the project:</h4>
Dir: config > database.yml

<pre>
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 10
  host: <%= ENV['DB_HOST'] %>
  database: <%= ENV['DB_NAME'] %>
  username: <%= ENV['DB_USER'] %>
  password: <%= ENV['DB_PASSWORD'] %>
development:
  <<: *default
  database: phalanx-development

#### Warning: The database defined as "test" will be erased and
#### re-generated from your development database when you run "rake".
#### Do not set this db to the same as development or production.

test:
  <<: *default
  database: phalanx-test

production:
  <<: *default
  database: phalanx-production

</pre>

<h3>* Database Seed configuration</h3>
<h4>* Command with read database config inside the project:</h4>
<pre>bundle exec rails db:reset
Description: drop + create + migrate + seed </pre>


* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions


<h2>* System dependencies</h2>

For this project was necessary this software do manangement docker containers:
<h4>Portainer</h4>
<pre>https://portainer.readthedocs.io/en/latest/deployment.html</pre>
<h4>Swarm Visualizer</h4>
<pre>https://github.com/ManoMarks/docker-swarm-visualizer</pre>


<h2>* ARM - Raspberrypi Configuration</h2>
<h4>* Network configuration</h4>
Dir: /etc/network/

<pre>
allow-hotplug wlan0
iface wlan0 inet static
        address 192.168.1.20
        netmask 255.255.255.0
        network 192.168.0.0
        gateway 192.168.0.1
        wpa-ssid kaiphe
        wpa-psk  ffffffffff
</pre>

<h4>* Command to restart network</h4>
<pre>/etc/init.d/networking restart</pre>

<h3>* Network configuration when reboot Raspberrypi </h3>
<h4>* Network configuration to rc.local level to wlan0 up when reboot Raspberrypi</h4>
Dir: /etc/rc.local

<pre>
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

iface wlan0 up

exit 0
</pre>

<h3>* Network configuration to able dhcp when reboot Raspberrypi</h3>
<h4>* Network configuration to able dhcp to eth0 and wlan0 up when reboot Raspberrypi</h4>
Dir: /etc/network/interfaces.d/eth0
<pre>
allow-hotplug eth0
iface eth0 inet dhcp
allow-hotplug wlan0
iface wlan0 inet dhcp
</pre>

<h2>ARM Raspberry Docker compose V2</h2>
[ARM Docker Compose V2](../blob/master/arm_linux/docker-compose.yml)

<h2>ARM Raspberry Docker compose V3</h2>
[ARM Docker Compose V3](../blob/master/arm_linux/docker-compose_3_version.yml)

<h2>ARM Raspberry Docker File</h2>
[Docker File](../blob/master/arm_linux/Dockerfile)

<h2>Necessary Configuration</h2>
In Dir: 
<pre>~/Docker_project/phalanx/arm_linux</pre>

<h4>Execute:</h4>

<h4>Copy the ARM Dockerfile to project home</h4>
<pre>cp Dockerfile ~/Docker_project/phalanx</pre>
<h4>And</h4>
<h4>Copy the ARM Docker-compose to project home</h4>
<pre>cp docker-compose.yml ~/Docker_project/phalanx/</pre>

<h3>* Main Docker commands </h3>
<h4>* Exec command inside container directly</h4>
<pre>
docker run --name=test-mysql --env="MYSQL_ROOT_PASSWORD=password" mysql
</pre>
<h4>* Clean Volume</h4>
<pre>docker volume rm $(docker volume ls -qf dangling=true)</pre>
<h4>* Inspect Container</h4>
<pre>docker inspect phalanx_db_1</pre>
<h4>* Service visualizer bound host network with container network</h4>
<pre>docker run -it -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock alexellis2/visualizer-arm</pre>
<h4>* Create a docker swarm service</h4>
<pre>docker service create --name web-nginx --replicas 4 --restart-max-attempts 3 --restart-window 5s --rollback-delay 3s --workdir /myapp/ -p 8080:80 nginx:alpine</pre>
<h4>* Docker stack deploy</h4>
<pre>docker stack deploy --compose-file=docker-compose.yml Hydra</pre>
<h4>* Docker exec command inside container</h4>
<pre>docker exec phalanx_app_1 bundle update newrelic_rpm</pre>
<h4>* Commit docker container for DockerHub</h4>
<pre>docker commit 3542b2ce5459 tsoarescruz/phalanx:phalanx_db</pre>
<h4>* Commit docker images for DockerHub</h4>
<pre>docker push --disable-content-trust tsoarescruz/phalanx:phalanx_db</pre>

<h2>*Git Repository Config </h2>
<h4>* Add git config fot a terminal</h4>
<pre>
git config --global user.name "Your Name"
git config --global user.email "youremail@domain.com"
</pre>
<h4>* Add ssh key to git</h4>
<bash>https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/</bash>


<h2>Docker Compose V2</h2>[Docker Compose V2](../blob/master/docker-compose.yml)

<h2>Docker File</h2>[Docker File](../blob/master/Dockerfile)



<h2>Last update:</h2>
<h2>Created by: Thiago Soares </h2>
