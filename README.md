# README

This document`s a end of TCC graduation of UVA - Universidade Veiga de Almeida
This documment references main steps to Docker - Swiss Army in  Rasperry Pi:

* Ruby version

<h2>* System dependencies</h2>

For this project was necessary this software do manangement docker containers:
<h4>Portainer</h4>
<pre>https://portainer.readthedocs.io/en/latest/deployment.html</pre>
<h4>Swarm Visualizer</h4>
<pre>https://github.com/ManoMarks/docker-swarm-visualizer</pre>

<h2>* ARM - Raspberrypi Configuration </h2>
<h4>* Network configuration</h4>
<pre>
Dir: /etc/network/

HypriotOS/armv7: root@black-pearl in /etc/network

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

<h2> ARM Raspberry Docker compose V2 </h2>[ARM Docker Compose V2](https://github.com/tsoarescruz/phalanx/blob/master/arm_linux/docker-compose.yml)

<h2> ARM Raspberry Docker compose V3 </h2>[ARM Docker Compose V3](https://github.com/tsoarescruz/phalanx/blob/master/arm_linux/docker-compose_3_version.yml)

<h2> ARM Raspberry Docker File</h2>[Docker File](https://github.com/tsoarescruz/phalanx/blob/master/arm_linux/Dockerfile)



<h2> Software Configuration</h2>
<h3>* Database creation</h3>
<h4>* Command with read database config inside the project:</h4>
<pre>bundle exec rails db:reset -> drop + create + migrate + seed</pre>

* Database initialization
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
* Configuration

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
<pre>"https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/"</pre>


<h2>Docker Compose V2</h2>[Docker Compose V2](../master/docker-compose.yml)

<h2>Docker File</h2>[Docker File](https://github.com/tsoarescruz/phalanx/blob/master/Dockerfile)



<h2>* Other suport documents: </h2>
<pre>

   ## Docker
    http://www.mundodocker.com.br/
    https://training.docker.com/self-paced-training
    https://www.docker.com/products/docker-toolbox
    https://blog.docker.com/2016/07/swarm-mode-on-a-raspberry-pi-cluster/
    http://imasters.com.br/desenvolvimento/devops/troubleshooting-e-dicas-de-docker/
    http://imasters.com.br/desenvolvimento/devops-aproveitando-o-melhor-dele/?trace=1519021197&source
    http://imasters.com.br/infra/aprendendo-mais-sobre-docker-e-flannel/?trace=1519021197&source=main-menu
    http://www.mundodocker.com.br/page/7/
    http://www.mundodocker.com.br/docker-e-flannel/
    http://www.mundodocker.com.br/o-que-e-container/
    http://www.mundodocker.com.br/o-que-e-docker/
    http://www.docker.com/products/docker#/azure
    https://docs.docker.com/engine/installation/linux/ubuntulinux/
    https://blog.docker.com/2016/06/docker-1-12-built-in-orchestration/
    https://docs.docker.com/engine/userguide/
    https://medium.com/@bossjones/how-i-setup-a-raspberry-pi-3-cluster-using-the-new-docker-swarm-mode-in-29-minutes-aa0e4f3b1768#.w5mrgtrmg
    https://www.ctl.io/developers/blog/post/what-does-docker-1-0-mean-for-the-community/

    ## docker-cheat-sheet
    https://github.com/wsargent/docker-cheat-sheet

    ## what-is-docker
    http://getawesomeness.herokuapp.com/get/docker#what-is-docker
    https://www.docker.com/what-docker





## Other oficiais documentations
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


Last update:
created by: Thiago Soares
