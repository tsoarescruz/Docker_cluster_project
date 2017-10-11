# README


This document`s a end of TCC graduation of UVA - Universidade Veiga de Almeida
This documment references main steps to Docker - Swiss Army in  Rasperry Pi:

* Ruby version

<pre>
* System dependencies

 For this project was necessary this software do manangement docker containers:

 * Portainer
https://portainer.readthedocs.io/en/latest/deployment.html

 * Swarm Visualizer
https://github.com/ManoMarks/docker-swarm-visualizer

</pre>

<pre>
* Configuration

  * Network configuration
--> /etc/network/

HypriotOS/armv7: root@black-pearl in /etc/network

allow-hotplug wlan0
iface wlan0 inet static
        address 192.168.1.20
        netmask 255.255.255.0
        network 192.168.0.0
        gateway 192.168.0.1
        wpa-ssid kaiphe
        wpa-psk  ffffffffff

   * Command to restart network

/etc/init.d/networking restart

   * Network configuration to rc.local level to wlan0 up when reboot Raspberrypi
--> /etc/rc.local

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

   * Network configuration to able dhcp to eth0 and wlan0 up when reboot Raspberrypi
--> /etc/network/interfaces.d/eth0

allow-hotplug eth0
iface eth0 inet dhcp
allow-hotplug wlan0
iface wlan0 inet dhcp

</pre>

* Database creation

 * Comando with read database config inside the project:
bundle exec rails db:reset -> drop + create + migrate + seed


* Database initialization


* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Configuration

<pre>
* Main Docker commands

 * Exec command inside container directly
docker run --name=test-mysql --env="MYSQL_ROOT_PASSWORD=password" mysql

 * Clean Volume
docker volume rm $(docker volume ls -qf dangling=true)

 * Inspect Container
 docker inspect phalanx_db_1

 * Service visualizer bound host network with container network
docker run -it -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock alexellis2/visualizer-arm

 * create a docker swarm service
docker service create --name web-nginx --replicas 4 --restart-max-attempts 3 --restart-window 5s --rollback-delay 3s --workdir /myapp/ -p 8080:80 nginx:alpine

 * Docker stack deploy
 docker stack deploy --compose-file=docker-compose.yml Hydra

</pre>

<pre>
* Other suport documents:
   
   * Docker Swarm V3
   https://codefresh.io/blog/deploy-docker-compose-v3-swarm-mode-cluster/
   
   * Heroku Pipeline
   https://www.heroku.com/

   * Clond Computing
   http://cloudcomputing.sys-con.com/node/4121976
   
   * Hypriot
   https://twitter.com/stefscherer?lang=en
   https://blog.hypriot.com/post/swarm-machines-or-having-fun-with-docker-machine-and-the-new-docker-swarm-orchestration/
   https://blog.hypriot.com/post/hypriotos-barbossa-for-raspberry-pi-3/
   https://blog.hypriot.com/post/setup-kubernetes-raspberry-pi-cluster/
   https://blog.hypriot.com/downloads/
   https://blog.hypriot.com/post/setup-kubernetes-raspberry-pi-cluster/
   https://github.com/hypriot/flash
   
   
   * Docker Docs
   https://blog.docker.com/2016/03/swarmweek-container-orchestration-docker-swarm/
   https://docs.docker.com/engine/swarm/
   https://docs.docker.com/engine/reference/builder/#healthcheck
   
     * Youtube
     DEEC 
     https://www.youtube.com/watch?v=M8uthk7k_2U&t=485s
     
     Visualizer
     https://www.youtube.com/watch?v=nK3fK-raLuw&t=178s
     

   * Docker Hub
     * Swarm
     https://hub.docker.com/_/swarm/
   
   * Github
     * Swarm
     https://github.com/docker/swarm
     
     * Kubernets
     https://github.com/luxas/kubernetes-on-arm
     https://github.com/kubernetes/dashboard#kubernetes-dashboard


   * Kubernets
   https://kubernetes.io/
   https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-intro/
   https://github.com/kubernetes/dashboard#kubernetes-dashboard
      * Youtube
      https://www.youtube.com/watch?time_continue=111&v=of45hYbkIZs
      
  
  * Mundo Docker
   https://www.mundodocker.com.br/docker-swarm-pratica/

  * Blogs
  http://blog.terranillius.com/post/composev3_swarm/
  https://github.com/mundodocker/exemplo-docker-compose/blob/master/docker-compose-v3.yml
</pre>

<pre>

*Git Config
   
  * Add git config fot a terminal
git config --global user.name "Your Name"
git config --global user.email "youremail@domain.com"

  * Add ssh key to git 
"https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/"

</pre>
